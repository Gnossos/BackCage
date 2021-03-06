#!/bin/bash
# backcage, version 1

# backcage.sh: Backup FreeBSD/FreeNAS/TrueNAS jails (iojails)
# Based on:
#   freenas-backup-jails by NasKar2 (https://github.com/NasKar2/freenas-backup-jails) commit 2020-09-20.
#   FreeNAS: Backup Jails Automatically Using IOCAGE Import and Export (2020-01-11) by raze42 
#       (https://digimoot.wordpress.com/2020/01/11/freenas-backup-jails-automatically-using-iocage-import-and-export/

# Modified by M. Feldman 2020-12-21, all rights reserved.

# TODO: Add initialization of the constants.
# TODO: Add the functions
# TODO: Move informative messages to the functions
# TODO: Add license

# FUNCTIONS

# Initialize the external functions
source functions
echo "After functions source"
echo "See what readconfig is returning"
#readconfig backcage.cfg
eval source <( readconfig backcage.cfg )
echo "config = $config"
echo "Now try to use it to set the variables"
#source readconfig backcage.cfg
#source <(readconfig backcage.cfg)
eval readconfig backcage.cfg
echo "poolname = $POOL_NAME"
exit

# Backup: Does all the backing up
function backup {
    # echo "if BACKUP_LOC"
    if [[ ! -d "$BACKUP_LOC" ]]; then
        echo "create "${BACKUP_LOC}
        mkdir -p "${BACKUP_LOC}"
    fi

    if [[ $# == 0 ]]; then
        echo "Backing up all cages."
    else
        echo "Backing up cages: $@."
    fi
    exit
}

# Restore: Restores what's needed:
function restore {
    #
    # Pick the restore directory
    #
    cd $BACKUP_LOC
    # shopt -s dotglob shopt -s nullglob array = (*)  <- Have to fix this

    for dir in "${array[@]}"; do echo; done

    for dir in */; do echo; done

    if [[ $# == 0 ]]; then
        echo "Restoring all jails."
    else
        echo "Restoring jails: $@."
    fi
    exit
}

# Initialize configuration
config_file="backcage.cfg"
echo "Configuration file: $config_file"
source <( "readconfig ${config_file}" )

echo "Pool name: $POOL_NAME"

# Configuration parameters
#echo "cron = $cron"
#echo "POOL_NAME = $POOL_NAME"
#echo "LOGS_LOC = $LOGS_LOC"
#echo "FILE_NAME = $FILE_NAME"
#echo "JAIL_DIR = $JAIL_DIR"
#echo "JAIL_IMAGE = "$JAIL_IMAGE"
#echo "FINAL = $FINAL"
#echo "BACKUP_DIR = "$BACKUP_DIR" # The actual directory of the current backup - this is is subdirectory of the main directory above with a timestamp
#echo "FULL_LOG_NAME = FULL_LOG_NAME"
#echo "maxNrOfBackups = $maxNrOfBackups" # The maximum number of backups to keep (when set to 0, all backups are kept)

exit

# ****** PROGRAM FLOW ******


# Initialize variables to their defaults
action = "Backup"     # Default action
mode = "Implicit"     # Default mode

# echo "Starting program flow structure $@ $#"
while getopts ":bBrRsS" opt;
do
    case "$opt" in
        b | B )
            backup ${@:2};
            ;;
        r | R )
            action = "Restore"
            restore ${@:2};
            ;;
        s | S)
            mode = "Select"
        \?) 
            echo "Usage: CageBack {-r, -R, -b, -B} <optional explicit list of jails>"
            exit 
            ;;
    esac
done
# Since getopts does nothing if no options are specified, force backup as default
if [[ $OPTIND == 1 ]]; then
    if [[ $# == 0 ]]; then
        echo "Default option is backup; default argument is all cages; backing up all cages"
        backup;
    else
        echo "Default option is backup; backing up cages: $@"
        backup $@
    fi
fi

exit

