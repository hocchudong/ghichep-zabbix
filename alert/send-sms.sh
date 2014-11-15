#!/bin/sh
HOME=/etc
PATH=/bin:/sbin:/usr/bin:/usr/sbin
LOGFILE="/var/log/zabbix-server/zabbix-sms.log"
DATE=`date +%Y-%m-%d:%H:%M:%S`

echo  $DATE >> ${LOGFILE}
echo "Recipient='$1' Message='$3'" >> ${LOGFILE}
 
MOBILE_NUMBER=`echo "$1" | sed s#\s##`
 
# Log it
#echo "echo $3 | /usr/bin/sudo /usr/bin/gnokii --sendsms ${MOBILE_NUMBER}" >>${LOGFILE}
echo "python /etc/zabbix/alert.d/send-sms.py ${MOBILE_NUMBER} "$3"" >>${LOGFILE}


# Send it
#echo "$3" | /usr/bin/sudo /usr/bin/gnokii --sendsms "${MOBILE_NUMBER}" 1>>${LOGFILE} 2>&1
python /etc/zabbix/alert.d/send-sms.py ${MOBILE_NUMBER} "$3" 1>>${LOGFILE} 2>&1

# EOF
