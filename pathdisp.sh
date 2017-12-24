#!/bin/sh
if [[ "$1" == "" ]]; then
  echo "$0: error no arg"
  exit 1
fi
target=$1
cache=${target}.geopath
if [ ! -f $cache ]; then
  echo "$0: error no geopath file"
  exit 2 
fi
cp $cache ${target}.pathdisp
file=${target}.pathdisp
awk '{ print $2, $3, $4, $5, $6; }' $file | \
  grep -v "Address not found" | \
  uniq | \
  tr "A-Z" "a-z" | \
  awk '{ print $1; }' | sed -e 's/,//' | xargs echo
  # awk '{ printf $2, $3, $4, $5; }' | xargs echo
exit 0
