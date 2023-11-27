#!/bin/bash

# Встановлення Oracle Instant Client
apt-get -y install libaio1
mkdir -p /opt/oracle
cd /opt/oracle
wget https://download.oracle.com/otn_software/linux/instantclient/211000/oracle-instantclient-basiclite-linuxx64.rpm
alien -i oracle-instantclient-basiclite-linuxx64.rpm

# Додавання шляху до sqlplus до PATH
export PATH=$PATH:/usr/lib/oracle/21/client64/bin

# З'єднання з Oracle-сервером і виконання тестів
sqlplus $1/$2@185.235.218.67:1521/XEPDB1 @TestCases.sql
