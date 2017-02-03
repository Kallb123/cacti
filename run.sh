#!/bin/sh

chown -R mysql /var/lib/mysql
chown -R www-data /var/lib/cacti
chown :syslog /var/log/
chmod 775 /var/log/
mkdir -p /var/log/apache2 /var/log/mysql /var/log/cacti
if [ ! -d "/var/lib/mysql/mysql" ]; then /usr/bin/mysql_install_db; fi

wget https://www.percona.com/downloads/percona-monitoring-plugins/1.1.6/percona-cacti-templates_1.1.6-1_all.deb
dpkg -i percona-cacti-templates_1.1.6-1_all.deb

echo '* * * * * www-data /usr/bin/php /usr/share/cacti/site/poller.php > /dev/null 2>&1' >> /etc/crontab

/etc/init.d/rsyslog start; /etc/init.d/mysql start ; /etc/init.d/apache2 start

if [ ! -d "/var/lib/mysql/cacti" ];
then mysql < /cacti.sql
fi
sed -i 's%$database_password.*%$database_password = "cacti";%' /usr/share/cacti/site/include/config.php

/usr/sbin/cron -f
