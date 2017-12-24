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
cp $cache ${target}.rtt
file=${target}.rtt
sed -i -e 's/\*//g'     $file
sed -i -e 's/ ms /  /g' $file
sed -i -e 's/ ms/ /g'   $file
sed -i -e 's/^ [0-9][0-9]*[ ]*/D/g' $file
sed -i -e 's/^[0-9][0-9]*[ ]*/D/g' $file
sed -i -e 's/^D[ ]*//g' $file
sed -i -e 's/[ ][ ]*/ /g' $file
sed -i -e 's/[0-9][0-9]*\.[0-9][0-9]*\.[0-9][0-9]*\.[0-9][0-9]*//g' $file
sed -i -e '/^[ ]*$/d' $file
tail -1 $file > ${target}.pingtimes
cat ${target}.pingtimes | awk '
/./ { 
if (NF==3) print ($1+$2+$3)/3;
if (NF==2) print ($1+$2)/2;
if (NF==1) print $1; 
}' > ${target}.pingavg
exit 0

