#!/bin/bash

# Install required packages with sudo
sudo apt-get update
sudo apt-get -y install libaio1 alien

# Download and install Oracle Instant Client
mkdir -p /opt/oracle
cd /opt/oracle

# Please check the Oracle website for the correct URL and replace it below
wget https://download.oracle.com/otn_software/linux/instantclient/211000/oracle-instantclient-basic-linuxx64.rpm

# Convert RPM to DEB
sudo alien -i oracle-instantclient-basic-linuxx64.rpm

# Add Oracle Instant Client to PATH
export PATH=$PATH:/usr/lib/oracle/21/client64/bin

# Connect to the Oracle server and run tests
sqlplus $1/$2@185.235.218.67:1521/XEPDB1 @TestCases.sql
