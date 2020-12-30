# Test config
# parse the config file and evaluate the output in the current shell
#source <( cat readconfig.sh )
source <( functions )
source <( readconfig config.file )
 
echo "fullname = $fullname"
echo "favouritefruit = $favouritefruit"
echo "needspeeling = $needspeeling"
echo "seedsremoved = $seedsremoved"
for i in "${!otherfamily[@]}"; do
    echo "otherfamily[$i] = ${otherfamily[i]}"
done
