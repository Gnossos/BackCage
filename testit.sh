# Read a configuration file.
# Source: http://rosettacode.org/wiki/Read_a_configuration_file#UNIX_Shell

readconfig() (
    # redirect stdin to read from the given filename
    exec 0<"$1"
 
    declare -l varname    # Original version forced everything to lowercase. Here we'll leave choice of case up to the software designer and user.
    while IFS=$' =\t' read -ra words; do
        # is it a comment or blank line?
        if [[ ${#words[@]} -eq 0 || ${words[0]} == ["#;"]* ]]; then
            continue
        fi
 
        # get the variable name
        varname=${words[0]}
 
        # split all the other words by comma
        value="${words[*]:1}"
        oldIFS=$IFS IFS=,
        values=( $value )
        IFS=$oldIFS
 
        # assign the other words to a "scalar" variable or array
        case ${#values[@]} in
            0) printf '%s=true\n' "$varname" ;;
            1) printf '%s=%q\n' "$varname" "${values[0]}" ;;
            *) n=0
               for value in "${values[@]}"; do
                   value=${value# }
                   printf '%s[%d]=%q\n' "$varname" $((n++)) "${value% }"
               done
               ;;
        esac
    done
)
 
# THESE COMMANDS ARE USED FOR TESTING THE FUNCTION
# parse the config file and evaluate the output in the current shell
#source <( readconfig config.file )
source <( readconfig backcage.cfg )
 
# Parse the configuration lines into the correct variables
CRON=$(eval echo $cron)
POOL_NAME=$(eval echo $pool_name)
LOGS_LOC=$(eval echo $logs_loc)
FILE_NAME=$(eval echo $file_name)
JAIL_DIR=$(eval echo $jail_dir)
JAIL_IMAGE=$(eval echo $jail_image)
BACKUP_LOC=$(eval echo $backup_loc)
FINAL=$(eval echo $final)
BACKUP_DIR=$(eval echo $backup_dir)
FULL_LOG_NAME=$(eval echo $full_log_name)
MAXNOFBACKUPS=$(eval echo $manofbackups)

echo $CRON
echo $POOL_NAME
echo $LOGS_LOC
echo $File_NAME
echo $JAIL_DIR
echo $JAIL_IMAGE
echo $BACKUP_LOC
echo $FINAL
echo $BACKUP_DIR
echo $FULL_LOG_NAME
echo $MAXnRoFbACKUPS
