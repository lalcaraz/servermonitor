timestamp() {
date +"%T"
}

MyS3BucketUri=my_bucket_name_in_s3
MyProjectName=my_proyect_name_

cd /home/ubuntu
mongodump
tar -zcvf "${MyProjectName}$(date '+%Y-%m-%d').tar.gz" dump/
s3cmd put "${MyProjectName}$(date '+%Y-%m-%d').tar.gz" s3://$MyS3BucketUri/"${MyProjectName}$(date '+%Y-%m-%d').tar.gz"
rm "${MyProjectName}$(date '+%Y-%m-%d').tar.gz"
rm -R dump/
