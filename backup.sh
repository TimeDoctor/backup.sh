#!/bin/bash
#PATH=/usr/local/bin:/usr/local/sbin:~/bin:/usr/bin:/bin:/usr/sbin:/sbin
# Path above is for macOS cron usage

# Get today's date
DATE=`date +%Y-%m-%d`

# Input all your database names you want dumped
export array="
	db1
	db2
	db3
"

# Loop for dumping each databases
for i in $array
do
	# --defaults-extra-file parameter will tell mysqldump to use the user/pass file stored
	# in the remote server so it dosn't prompt you the password
	ssh user@server.com "mysqldump --defaults-extra-file=/path/to/mysqldump/pwfile/.hidden-pw-file $i > /path/to/backup/$i.sql"
done

# Loop for downloading your projects && zipping them
for i in $array
do
	# Locally make a directory based on today's date and database name
	mkdir -p /path/to/backup/$DATE/$i
	# Download all SQL files
	scp user@server.com:/path/to/backup/$i.sql /path/to/backup/$DATE/$i/$i.sql
	# Download all project files
	scp -r user@server:/path/to/project/$i /path/to/backup/$DATE/$i
	# Change to backup directory and zip it
	cd /path/to/backup/$DATE && zip -r $i.zip $i
	# Remove project directory
	rm -rf /path/to/backup/$DATE/$i
done

# Remove mysqldump files in remote server && close connection
ssh user@server.com rm /path/to/backup/* && exit