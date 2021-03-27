#!/usr/bin/env bash

object_list=$1
mode=$2
duration_in_seconds=${3:-10}
pause=${4:-1}
region=${5:-"eu-west-1"}

downloads="./downloads"
rm -rf $downloads
mkdir $downloads

function usage {
  echo >&2 "Usage: $0 object_list api|sdk [duration_in_seconds=10] [pause=1]"
  exit 1
}

if [[ -z $mode || -z $object_list || ($mode != 'api' && $mode != 'sdk') ]]; then 
  usage
fi

if [[ ! -f "$object_list" ]]; then 
  echo >&2 "ERROR: $object_list does not exist"
  usage
fi

end_at=$(( $(date +%s) + duration_in_seconds ))


while [[ $(date +%s) -le $end_at ]]; do
  object="$(shuf -n 1 "$object_list")"
  if [[ $mode == "api" ]]; then 
    object="$(./http-url.py "$region" "$object")"
    wget "$object" -O "$downloads/$(basename "$object")" --quiet
    echo "$object,$?"
  else
    echo >&2 "WARN: sdk mode is not implemented yet"
  fi
  
  sleep "$pause"
done
