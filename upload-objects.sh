#!/usr/bin/env bash

bucket=$1
datdir=${2:-./data}
acl=${S3_ACL:-public-read}
storage_class=${S3_STORAGE_CLASS:-STANDARD_IA}

if [[ -z $bucket ]]; then 
  echo >&2 "Usage: $0 bucket [data-dir]"
  exit 1
fi

aws s3 sync "$datdir" "s3://$bucket" \
       --acl "$acl" \
       --storage-class "$storage_class" \
       --delete \
       --no-progress >&2 

for file in $datdir; do
  echo "s3://$bucket/$(basename "$file")"
done