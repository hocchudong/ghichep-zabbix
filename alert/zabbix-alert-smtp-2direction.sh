#!/usr/bin/python
# -*- coding: utf-8 -*-
"""
Zabbix SMTP Alert script for gmail.
"""
import argparse
import sys
import smtplib
import table_vms_bandwidth_2direction as tbl
from email.MIMEText import MIMEText
from email.Header import Header
from email.Utils import formatdate

# Mail Account
MAIL_ACCOUNT = 'thienha3110@gmail.com'
MAIL_PASSWORD = '19912009'

# Sender Name
SENDER_NAME = u'Zabbix Alert'

# Mail Server
SMTP_SERVER = 'smtp.gmail.com'
SMTP_PORT = 587
# TLS
SMTP_TLS = True

def send_mail(recipient, subject, body, encoding='utf-8'):
    session = None
    if 'inbound' in body and 'Network node' in body:
        table = tbl.main('inbound')
    elif 'outbound' in body and 'Network node' in body:
        table = tbl.main('outbound')
    else:
        table = None
    bd = body + '\n\n\n\n' + table
    msg = MIMEText(bd, 'plain', encoding)
   # msg = MIMEText(table, 'plain', encoding)
    msg['Subject'] = Header(subject, encoding)
    msg['From'] = Header(SENDER_NAME, encoding)
    msg['To'] = recipient
    msg['Date'] = formatdate()
    try:
        session = smtplib.SMTP(SMTP_SERVER, SMTP_PORT)
        if SMTP_TLS:
            session.ehlo()
            session.starttls()
            session.ehlo()
            session.login(MAIL_ACCOUNT, MAIL_PASSWORD)
        session.sendmail(MAIL_ACCOUNT, recipient, msg.as_string())
    except Exception as e:
        raise e
    finally:
        # close session
        if session:
            session.quit()

if __name__ == '__main__':
    """
    recipient = sys.argv[1]
    subject = sys.argv[2]
    body = sys.argv[3]
    """
    argp = argparse.ArgumentParser(description='Lay thong tin gui mail')
    argp.add_argument('recipient', type=str, help='Recipient')
    argp.add_argument('subject', type=str, help='Subject')
    argp.add_argument('body', type=str, help='Body')
    args = argp.parse_args()

    send_mail(
        recipient=args.recipient,
        subject=args.subject,
        body=args.body)
#     else:
#         print u"""requires 3 parameters (recipient, subject, body)
# \t$ zabbix-gmail.sh recipient subject body
# """
