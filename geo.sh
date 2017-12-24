#!/bin/sh
if [[ "$1" == "" ]]; then
  echo "$0: error no arg"
  exit 1
fi
target=$1
cache=${target}.traceroute
if [ ! -f $cache ]; then
  echo "$0: error no traceroute file"
  exit 2 
fi
sed -i -e 's/\*//g' $cache
grep -w ms $cache | awk '{ print $2; }' > $target.route
for h in `cat $target.route`
do 
  printf "%16s " $h
  geoiplookup $h | sed -e 's/GeoIP Country Edition://g' 
done # > ${target}.geopath
exit 0  
