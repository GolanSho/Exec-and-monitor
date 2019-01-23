#!/usr/bin/env bash
######################################
# Created By Golansho
#
# Date - 23/1/19
#
# Purpose : Monitoring User processes
#
# Ver : 2.0.0
######################################
#set -x
#######

######  Prep  ######

	shift $((OPTIND-1))
                                ####  Setting getopts on scd ####
while getopts ":scd" opt; do
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
   \?)	      
      echo "Invalid option"
      ;;
    :)
      echo "please choose option"
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

######  End  ######
