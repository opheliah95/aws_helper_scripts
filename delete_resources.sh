# This script will delete avaliable aws region and resources
for region in `aws ec2 describe-regions --query 'Regions[].RegionName' --output text`
do
    echo "region = ${region}"
    result=$(aws resourcegroupstaggingapi \
        get-resources --region ${region} \
        --query 'ResourceTagMappingList[].ResourceARN' \
        --output text)

    result_refined=$(echo ${result} | sed -r 's/(\[|\])//g')
    if ! [ -z "$result_refined" ]
    then
        # now delete the resource
        for resource in ${result_refined}
        do
            # find last col which contains id
            id=$(echo ${resource} | awk -F: '{print $NF}' | awk -F/ '{print $NF}')
            echo "$id identified"
            
            # get the resource type
            len=${#id} # the : at the end
            len=$(($len + 1)) 
            echo "the length of string to be cut is: $len"
            r_type=$(echo ${resource::-len}| awk -F: '{print $NF}')
            echo "resource type is $r_type"

        done
    else
        printf "result is empty for ${region} \n\n"
    fi

done