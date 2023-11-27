#!/bin/bash

# Встановлення Oracle Instant Client
apt-get -y install libaio1
mkdir -p /opt/oracle
cd /opt/oracle
wget https://download.oracle.com/otn_software/linux/instantclient/211000/oracle-instantclient-basiclite-linuxx64.rpm
alien -i oracle-instantclient-basiclite-linuxx64.rpm
