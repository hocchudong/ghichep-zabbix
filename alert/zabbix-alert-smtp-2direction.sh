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
from email.mime.multipart import MIMEMultipart
from email.Header import Header
from email.Utils import formatdate

# Mail Account
MAIL_ACCOUNT = ''
MAIL_PASSWORD = ''
NETWORK_NODE = 'Network node' #Khai bao host cua Network Node tren Zabbix Server
COMPUTE_NODE = 'Compute' #Khai bao hostname chung cua node Compute tren Zabbix
# Sender Name
SENDER_NAME = u'Zabbix Alert'

# Mail Server
SMTP_SERVER = 'smtp.gmail.com'
SMTP_PORT = 587
# TLS
SMTP_TLS = True

def send_mail(recipient, subject, body, encoding='utf-8'):
    session = None
    if 'Network inbound' in body and 'PROBLEM' in body:
        if NETWORK_NODE in body or COMPUTE_NODE in body:
            table = tbl.main('inbound')
    elif 'Network outbound' in body and 'PROBLEM' in body:
        if NETWORK_NODE in body or COMPUTE_NODE in body:
            table = tbl.main('outbound')
    else:
        table = ''
    bd = body + '\n\n\n\n'
    msg = MIMEText(bd, 'plain', encoding)
   # msg = MIMEText(table, 'plain', encoding)
    msg = MIMEMultipart("test")
    msg1 = MIMEText(bd, 'plain', encoding)
    msg2 = MIMEText(table, 'html', encoding)
    msg['Subject'] = Header(subject, encoding)
    msg['From'] = Header(SENDER_NAME, encoding)
    msg['To'] = recipient
    msg['Date'] = formatdate()
    msg.attach(msg1)
    msg.attach(msg2)
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
