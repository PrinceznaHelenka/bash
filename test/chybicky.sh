#!/bin/bash
#set -x

cd ../src
echo -e "\e[105mTed se dejou kouzla
\e[0m"

overovani () 
{
	cd ../vystup

	rozdily1=$(diff standardniVystup.txt vzor1.txt) 
	if [ "$rozdily1" = "" ] 
	then
		  echo -e "\e[92mVse bezi spravne.\e[0m"

	else 
		  echo -e "\e[91mVe standardnim vystupu je neco navic.\e[0m"
	fi

	rozdily2=$(diff chybovyVystup.txt vzor2.txt) 
	if [ "$rozdily2" = "" ] 
	then
		  echo -e "\e[92mV chybovem vzstupu jsem nenasla zadnou chybu.\e[0m"
	else 
		  echo -e "\e[91mChybovy vystup hlasi chybu.\e[0m"
	fi

	cd ../src
}

#vse by melo bezet spravne
echo -e "\e[96mPrvni test\e[0m"
./verzeWildfly.sh 10.1.0.Final ../vystup > ../vystup/standardniVystup.txt 2> ../vystup/chybovyVystup.txt

overovani

#je zadana spatna verze
echo -e "\e[96mDruhy test\e[0m"
./verzeWildfly.sh 10.1.0.F ../vystup > ../vystup/standardniVystup.txt 2> ../vystup/chybovyVystup.txt

overovani

#je zadano chybne umisteni
echo -e "\e[96mTreti test\e[0m"
./verzeWildfly.sh 10.1.0.Final vystup > ../vystup/standardniVystup.txt 2> ../vystup/chybovyVystup.txt

overovani

#je zadano pouze spusteni wildfly a zadny parametr
echo -e "\e[96mCtvrty test\e[0m"
./verzeWildfly.sh > ../vystup/standardniVystup.txt 2> ../vystup/chybovyVystup.txt

overovani

#je zadano vice parametru, nez je treba
echo -e "\e[96mPaty test\e[0m"
./verzeWildfly.sh 10.1.0.Final ../vystup clear > ../vystup/standardniVystup.txt 2> ../vystup/chybovyVystup.txt

overovani

#exoticka syntaxe
echo -e "\e[96mSesty test\e[0m"
./verzeWildfly.sh $(10.1.0.Final) ../vystup > ../vystup/standardniVystup.txt 2> ../vystup/chybovyVystup.txt

overovani


#exoticka syntaxe
echo -e "\e[96mSedmy test\e[0m"
./verzeWildfly.sh 10.1.0.Final $(../vystup) > ../vystup/standardniVystup.txt 2> ../vystup/chybovyVystup.txt

overovani

#exoticka syntaxe
echo -e "\e[96mOsmy test\e[0m"
./verzeWildfly.sh "10.1.0.Final" "../vystup >" ../vystup/standardniVystup.txt 2> ../vystup/chybovyVystup.txt

overovani

#spatne spusteni skriptu
echo -e "\e[96mDevaty test\e[0m"
./verzeWildfly.sh: 10.1.0.Final ../vystup > ../vystup/standardniVystup.txt 2> ../vystup/chybovyVystup.txt

overovani

#nadbytecne ostre zavorky
echo -e "\e[96mDesaty test\e[0m"
./verzeWildfly.sh 10.1.0.Final <../vystup> > ../vystup/standardniVystup.txt 2> ../vystup/chybovyVystup.txt

overovani

cd ../vystup
rm -rf standardniVystup.txt
rm -rf chybovyVystup.txt

#co jsem se naucila nebo taky ne

#echo "zdravim"  2>&1 | tee ~/VerzeWildfly/vystup.txt
#open vystup.txt /  gedit

