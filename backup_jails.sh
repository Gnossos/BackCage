#!/bin/bash

# Backup TrueNAS jails
# Based on script by raze42 @ https://digimoot.wordpress.com/2020/01/11/freenas-backup-jails-automatically-using-iocage-import-and-export/
# Modified by M. Feldman 2020/12/16.

# System locations
jailroot = "/mnt/Volume1/iocage/"
jaildir = "${jailroot}jails/"
log = "/mnt/Volume1/Homes/admin/logs/jail.log"
backups = "/mnt/Volume1/Homes/admin/backups/"


# Start a new log file
echo "---Starting Backup of TrueNAS Jails ---" >> $log
echo $(date) >> $log

jaillist = `ls jaildir`
echo "...Jails to backup: ${jaillist}" >> $log

for jail in $jaillist
do
	iocage stop $jail >> $log
	iocage export $jail >> $log
	iocage start $jail >> $log
	echo "...Deleting old backups" >> $log
	echo ${date} >> $log
	rm "${backups}${jail}" >> $log
	echo "...Moving current backup to storage folders" >> $log
	echo ${date} >> $log
	mv -v ${jaildir}images/${jail}* ${backups}${jail} >> $log
done

echo "...Jails are backed up locally." >> $log
echo ${date} >> $log

echo "---Beginning off-site backup with Duplicati." >> $log
echo ${date} >> $log

# duplicati comannds go here.

echo "...Off-site backup completed." >> $log
echo ${date} >> $log
