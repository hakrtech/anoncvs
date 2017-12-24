#!/bin/sh
/bin/rm -f *.traceroute

if [ ! -f anoncvs.html ]; then
  curl -s https://www.openbsd.org/anoncvs.html > anoncvs.html 
fi

cat anoncvs.html | \
    grep CVSROOT= | \
    awk -F= '{ print $2; }' | \
    awk -F: '{ print $1; }' | \
    awk -F@ '{ print $2; }' > ANONCVS

for h in `cat ANONCVS`
do
  # echo $h
  if [ ! -f $h.traceroute ]; then
    nohup traceroute -n -w 2 -q 2 -m 25 $h > $h.traceroute &
  fi
done
RUNNING=`ps ax | grep traceroute | wc -l` 
echo -n waiting
while :
do
  if [ $RUNNING -eq 0 ]; then
    echo ""
    exit 0
  fi
  sleep 1
  echo -n "."
  RUNNING=`ps ax | grep traceroute | wc -l` 
done

