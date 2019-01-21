#!/usr/bin/env bash
######################################
# Created By Golansho
#
# Date - 21/1/19
#
# Purpose : Monitoring currect user processes
#
# Ver : 1.0.0
######################################

#set -x
#######
                    
         ### Description ###
# In order to stop, delete ./usrprcfil.mon

         ### Prep ###

f_strtmon(){

select opt in Start Cancel
	
	do
	 case $opt in
	  "Start")
	    touch ./usrprcfil.mon
 ;;
	  "Cancel")
	    echo "monitoring canceled"
	
	esac
	 break
done	
} 				## if user select 1 then start if cancel then stop
f_monusrprc(){

if [ -f ./usrprcfil.mon ];
  then 
    while [ -f ./usrprcfil.mon  ] 
	do ps -U $USER |tee './usrprcfil.mon' > /dev/null
    done
fi	     		        
}				## if file usrprcfil.mon exist then ps -u to him
       ### Main ###

echo "to start monitoring currect user processes press Start"

f_strtmon
f_monusrprc &


 
