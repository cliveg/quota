# Define Regions to check as an array
locations=( westus2 eastus2 eastus canadacentral southcentralus )

# Write CSV Header
echo subscription,subscriptionname, location,name,description,currentValue,limit> quota.csv

# Loop for each subscription
for subscription in `az account list --query "[].{subscription:id}" -o tsv`; do
    export subscriptionName=$(az account show --subscription $subscription --query name -o tsv)
    echo "Working On: $subscription $subscriptionName"

    # Loop for supplied Regions
    for location in "${locations[@]}"
    do
        echo "Working On: $location"

        # Get quota for subscription
        export quotastring=$(az vm list-usage -l $location --subscription $subscription --query "[?currentValue!='0'].{name:name.value, description:localName, currentValue:currentValue, limit:limit}")

        # Loop for each row
        for row in $(echo "${quotastring}" | jq -r '.[] | @base64'); do
            _jq() { 
            echo ${row} | base64 --decode | jq -r ${1} 
            }
            # Extract properties to use in CSV output
            export name=$(cut -d'=' -f2 <<<$(_jq '.name'));
            export description=$(cut -d'=' -f2 <<<$(_jq '.description'));
            export currentValue=$(cut -d'=' -f2 <<<$(_jq '.currentValue'));
            export limit=$(cut -d'=' -f2 <<<$(_jq '.limit'));

            # Quotas to exclude
            if [[ "$name" != "PremiumDiskCount" && "$name" != "availabilitySets" && "$name" != "ZRSSnapshotCount" && "$name" != "StandardSSDDiskCount" && "$name" != "StandardSnapshotCount" && "$name" != "Gallery" && "$name" != "GalleryImage" && "$name" != "GalleryImageVersion" && "$name" != "StandardDiskCount" && "$name" != "virtualMachineScaleSets" && "$name" != "virtualMachineScaleSets" ]]; then
                # Write CSV line by line
                echo $subscription,$subscriptionName,$location,$name,$description,$currentValue,$limit >> quota.csv
            fi
        done

    done
done
cat quota.csv