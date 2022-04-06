# This script will loop through all avaliable aws region and resources
for region in `aws ec2 describe-regions --query 'Regions[].RegionName' --output text`
do
    echo "region = ${region}"
    aws resourcegroupstaggingapi get-resources --region ${region} --query 'ResourceTagMappingList[].ResourceARN';
done