# This script will delete avaliable aws region and resources
for region in `aws ec2 describe-regions --query 'Regions[].RegionName' --output text`
do
    echo "region = ${region}"
    result=$(aws resourcegroupstaggingapi \
        get-resources --region ${region} \
        --query 'ResourceTagMappingList[].ResourceARN')

    result_refined=$(echo ${result} | sed -r 's/(\[|\])//g')
    # now delete the resource
    for resource in ${result_refined}
    do
        echo ${resource} | cut -d ":" -f6
    done

done