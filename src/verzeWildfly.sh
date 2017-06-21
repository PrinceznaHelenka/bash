#!/bin/bash
#set -x

if [ -e $2 ]
then 
	echo -e "\e[92mTed se zjistuje, jaka je aktualni verze wildfly.\e[0m" 
else
	echo -e "\e[96mZadej spravnou slozku!\e[0m"
	exit 1
fi


if ! [ -e $2/wildfly ] 
then
     cd $2 		
     wget http://download.jboss.org/wildfly/$1/wildfly-$1.zip 

	if ! [ $? == 0 ]
	  then  
		echo -e "\e[96mZadej spravnou verzi!\e[0m"
		exit 1
	fi  

     unzip -q wildfly-$1.zip -d wildfly 
    
fi

cd $2/wildfly/wildfly-$1/   
./bin/standalone.sh > /dev/null &
sleep 20s

zabit=`jps | grep "jboss" | sed "s/jboss.*//" `
kill $zabit
#pwd
grep "services are lazy, passive or on-demand" standalone/log/server.log | tail -1 | sed 's/.* Full //' | sed "s/ (.*//"

cd ../..  
#nebo $2
rm -rf wildfly
rm -rf wildfly-$1.zip


