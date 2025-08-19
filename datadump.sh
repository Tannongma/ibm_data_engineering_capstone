#!/bin/sh
# The above line tells the interpreter this code needs to be run as a shell script.

# Set the database or artifact name to a variable. 
DATABASE='sales'
TABLE='sales_data'

# This will be printed on to the screen. In the case of cron job, it will be printed to the logs.
echo "Pulling $DATABASE Database ..."

# Set the folder where the database backup will be stored
backupfolder='/home/project/de_project_repo'

sqlfile=$backupfolder/sales_data.sql

# Create a backup

if mysqldump $DATABASE $TABLE > $sqlfile ; then
   echo 'Sql dump created'
else
   echo 'mysql_dump return non-zero code No backup was created!' 
   exit
fi

