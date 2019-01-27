#!/usr/bin/env bash
######################################
# Created By Golansho
#
# Date - 23/1/19
#
# Purpose : Monitoring User processes
#
# Ver : 2.1.0
######################################
#set -x
#######

######  Description  ######

# To start give -s #
# To cancel give -c #
# To Stop give -d #
# To Suspend give -b #
######  Prep  ######

	shift $((OPTIND-1))
                                ####  Setting getopts on scdbr ####
while getopts ":scdbr" opt; do
  case $opt in
    s)
      Start=1
      ;;
    c)
      Cancel=1
      ;;	
    d)
      Delete=1
      ;;
    b)
      Break=1
      ;;
    r)
      Return=1
      ;;
   \?)	      
      echo "Invalid option"
      ;;
    :)
      echo "please choose option (-scdbr)"
      ;;
  esac
done

f_monusrprc(){
                                  ####  func for monitor ####
if [ -f ./usrprcfil.mon ];
  then
    while [ -f ./usrprcfil.mon  ] 
        do ps -U $USER |tee './usrprcfil.mon' > /dev/null
    done
fi
}

pid=$(pgrep -f procmon) 

######  Start  ######
                                   ####  what to do with getopts  ####
if [[ $Start = 1 ]]; then
  touch ./usrprcfil.mon ; echo "Start Monitoring" &&
  f_monusrprc &
fi

if [[ $Cancel = 1 ]]; then
  echo "Monitoring Cancelled"
fi

if [[ $Delete = 1 ]]; then
  rm ./usrprcfil.mon && echo "Monitoring Stopped" || 
  echo "Monitor not active"
fi

pid=$(pgrep -f prcmon)

if [[ $Break = 1 ]]; then
  kill -STOP $pid 
fi

if [[ $Return = 1 ]]; then
  kill -CONT $pid
fi

######  End  ######
