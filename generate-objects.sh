#!/usr/bin/env bash

# shellcheck disable=2086

numobjs=${1:-10}
datdir=./data
rm -rf $datdir
mkdir $datdir

i=0
while [[ $i -lt $numobjs ]]; do 
  tmpfile=$(mktemp /tmp/s3obj.XXXXXX)
  dd if=/dev/urandom bs=$((128*1024)) count=1 > $tmpfile 2>/dev/null

  datfile=$(shasum $tmpfile | cut -d' ' -f1).dat
  mv $tmpfile $datdir/$datfile
  echo $datdir/$datfile

  i=$((i + 1))
done
