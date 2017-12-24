#!/bin/sh
./trace.sh
for h in `cat ANONCVS`
do
  # echo $h
  geo.sh $h > $h.geopath &
done

for h in `cat ANONCVS`
do 
  # echo $h; cat $h.geopath
done

for h in `cat ANONCVS`
do
  rtt.sh $h 
done

for h in `cat ANONCVS`
do 
  N=`grep "US," $h.geopath | wc -l`
  if [ $N -eq 0 ]; then
    usa="ok "
  else
    usa="!! "
  fi
  pingavg=`cat $h.pingavg`
  printf "%32s %.3f %s path " $h $pingavg $usa; pathdisp.sh $h 
done | sort +1 > do.report.txt
echo \# no usa
grep ok do.report.txt
echo
echo \# usa in path or destination
grep -v ok do.report.txt 
for h in `cat ANONCVS`
do 
  rm -f ${h}.*
done
# rm -f ANONCVS
exit 0
