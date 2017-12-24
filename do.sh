#!/bin/sh
./trace.sh
for h in `cat ANONCVS`
do
  # echo $h
  nohup geo.sh $h > /dev/null &
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
done | sort +1
exit 0
