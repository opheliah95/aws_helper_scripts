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
            echo ${resource} | cut -d ":" -f6
        done
    else
        printf "result is empty for ${region} \n\n"
    fi

done