#!/bin/sh
if [ "$1" = "" ] ; then
 echo "you must provide a search expression to use with grep"
  exit -1
fi

forcekill=n

if [ "$2" = "forcekill" ] ; then
 echo "kill will no ask confirmation"
 forcekill=y
fi

#echo $(ps aux |grep $1|grep -v grep|awk '{{printf "%s ",$2}; for (i=12; i <= NF; i++) {printf "%s ",$i};print "XXXXXXXX"}')|sed 's/XXXXXXXX/\n/g'|sed 's/^ //'
processes=$(echo $(ps aux |grep $1|grep -v grep|awk '{print $2}'))

if [ -z "$processes" ]; then 
    echo "process not found"
    exit -2
fi

#echo $(ps --pid $(echo $processes)|awk '{{printf "%s ",$1}; for (i=6; i <= NF; i++) {printf "%s ",$i};print "XXXXXXXX"}')|sed 's/XXXXXXXX/\n/g'|sed 's/^ //'|sed 's/ .*//'|tail -n +2
#echo $(ps aux |grep $processes)

for i in ` echo  $processes `; do ps aux |grep $i ; done

echo ""
echo " "
echo PID
echo $(ps --pid $(echo $processes)|awk '{{printf "%s ",$1}; for (i=6; i <= NF; i++) {printf "%s ",$i};print "XXXXXXXX"}')|sed 's/XXXXXXXX/\n/g'|sed 's/^ //'|sed 's/ .*//'|tail -n +2


if [ $forcekill = "y" ] ; then
    yn=y
else    
    echo -n "Do you want kill these process? [yN]"
    read yn
    if [ -z "$yn" ]; then
        yn=n
    fi
fi    
if [ $yn = "y" ]; then
    command="kill -9 $(echo $processes)"
    echo $command
    $(eval $command)
    echo "process(es) killed"
else
echo "process(es) NOT killed"
fi

