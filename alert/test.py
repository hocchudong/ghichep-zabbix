import smtplib
from email.mime.text import MIMEText
from email.mime.multipart import MIMEMultipart
from email.Header import Header
from email.Utils import formatdate
# just an example, you format it usng html

# MAIL_ACCOUNT = 'thienha3110@gmail.com'
# MAIL_PASSWORD = '19912009'

MAIL_ACCOUNT = 'mycloudvnn@vdc.com.vn'
MAIL_PASSWORD = 'Vdc1T@!ma1l'


#SENDER_NAME = u'Zabbix Alert'

# Mail Server
# SMTP_SERVER = 'smtp.gmail.com'
# SMTP_PORT = 587
SMTP_SERVER = 'smtp.vdc.com.vn'
SMTP_PORT = 25


# TLS
# SMTP_TLS = True
Check = True

#html = "<html><body><table><tr><td>name</td><td><age></td><td>dob</td<tr></table></body></html>"
html = """<table>
<tr><th>Host        </th><th>Instance_ID                         </th><th>Instance_Name   </th><th>Value       </th><th>Time                      </th></tr>
<tr><td>VDCITC011104</td><td>db7f0e9b-707f-463b-997c-4a58e8008f0a</td><td>sso-centos      </td><td>0.01000 Mbps</td><td>2015-07-26T11:30:57.718000</td></tr>
<tr><td>VDCITC011104</td><td>db7f0e9b-707f-463b-997c-4a58e8008f0a</td><td>sso-centos      </td><td>0.01000 Mbps</td><td>2015-07-26T11:29:57.664000</td></tr>
<tr><td>VDCITC011104</td><td>db7f0e9b-707f-463b-997c-4a58e8008f0a</td><td>sso-centos      </td><td>0.01000 Mbps</td><td>2015-07-26T11:28:57.767000</td></tr>
<tr><td>VDCITC011104</td><td>db7f0e9b-707f-463b-997c-4a58e8008f0a</td><td>sso-centos      </td><td>0.02000 Mbps</td><td>2015-07-26T11:27:57.591000</td></tr>
<tr><td>VDCITC011104</td><td>db7f0e9b-707f-463b-997c-4a58e8008f0a</td><td>sso-centos      </td><td>0.01000 Mbps</td><td>2015-07-26T11:26:57.515000</td></tr>
<tr><td>VDCITC011102</td><td>c8a41a78-2d2b-4b1e-88da-c73dce1f8d46</td><td>oep_linux_02    </td><td>0.01000 Mbps</td><td>2015-07-26T11:31:07.306000</td></tr>
<tr><td>VDCITC011104</td><td>db7f0e9b-707f-463b-997c-4a58e8008f0a</td><td>sso-centos      </td><td>0.01000 Mbps</td><td>2015-07-26T11:25:57.474000</td></tr>
<tr><td>VDCITC011102</td><td>c8a41a78-2d2b-4b1e-88da-c73dce1f8d46</td><td>oep_linux_02    </td><td>0.01000 Mbps</td><td>2015-07-26T11:30:07.468000</td></tr>
<tr><td>VDCITC011104</td><td>db7f0e9b-707f-463b-997c-4a58e8008f0a</td><td>sso-centos      </td><td>0.01000 Mbps</td><td>2015-07-26T11:24:57.453000</td></tr>
<tr><td>VDCITC011104</td><td>db7f0e9b-707f-463b-997c-4a58e8008f0a</td><td>sso-centos      </td><td>0.01000 Mbps</td><td>2015-07-26T11:23:57.621000</td></tr>
<tr><td>VDCITC011102</td><td>c8a41a78-2d2b-4b1e-88da-c73dce1f8d46</td><td>oep_linux_02    </td><td>0.01000 Mbps</td><td>2015-07-26T11:28:07.199000</td></tr>
<tr><td>VDCITC011104</td><td>db7f0e9b-707f-463b-997c-4a58e8008f0a</td><td>sso-centos      </td><td>0.01000 Mbps</td><td>2015-07-26T11:22:57.528000</td></tr>
<tr><td>VDCITC011104</td><td>db7f0e9b-707f-463b-997c-4a58e8008f0a</td><td>sso-centos      </td><td>0.01000 Mbps</td><td>2015-07-26T11:21:57.317000</td></tr>
</table>
"""

msg1 = MIMEText(html,'html')
msg = MIMEMultipart("test")
msg['Subject'] = "Test send html"
# msg['From'] = "thienha3110@gmail.com"
msg['To'] = "zabbix.vdcit@gmail.com"
msg['Date'] = formatdate()
msg.attach(msg1)
try:
        session = smtplib.SMTP(SMTP_SERVER, SMTP_PORT)
        if Check:
            session.ehlo()
            # session.starttls()
            # session.ehlo()
            session.login(MAIL_ACCOUNT, MAIL_PASSWORD)
        session.sendmail(MAIL_ACCOUNT, 'zabbix.vdcit@gmail.com', msg.as_string())
except Exception as e:
        raise e
finally:
        # close session
        if session:
            session.quit()