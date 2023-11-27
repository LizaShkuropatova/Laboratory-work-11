#!/bin/bash

# З'єднання з Oracle-сервером і виконання тестів
sqlplus $1/$2@185.235.218.67:1521/XEPDB1 @TestCases.sql
