#!/bin/bash
NC='\033[0m'
RED='\033[1;38;5;196m'
GREEN='\033[1;38;5;040m'
ORANGE='\033[1;38;5;202m'
BLUE='\033[1;38;5;012m'
BLUE2='\033[1;38;5;032m'
PINK='\033[1;38;5;013m'
GRAY='\033[1;38;5;004m'
NEW='\033[1;38;5;154m'
YELLOW='\033[1;38;5;214m'
CG='\033[1;38;5;087m'
CP='\033[1;38;5;221m'
CPO='\033[1;38;5;205m'
CN='\033[1;38;5;247m'
CNC='\033[1;38;5;051m'

function banner(){
echo -e ${RED}"##########################################################"                                                    
echo -e ${CP}"     _____     _             ____  __  __ ____           #"    
echo -e ${CP}"    |  ___|_ _| | _____     / ___||  \/  / ___|          #"
echo -e ${CP}"    | |_ / _  | |/ / _ \____\___ \| |\/| \___ \          #"
echo -e ${CP}"    |  _| (_| |   <  __/_____|__) | |  | |___) |         #"
echo -e ${CP}"    |_|  \__,_|_|\_\___|    |____/|_|  |_|____/          #"
echo -e ${BLUE}"                                                        #"
echo -e ${BLUE}"      Social Engineering Outil de messagerie SMS         #"
echo -e ${RED}"   ATTENTION : Pour usage professionel ou d'apprentissage  #"
echo -e ${RED}"             Je ne serai pas responsable de vos actes     #"
echo -e ${YELLOW}"            Coded By: Joshua Bende Falanga aka bashl0re #"
echo -e ${GREEN}"             https://twitter.com/jbf_se                 #"
echo -e ${RED}"##########################################################"
   
}
resize -s 38 70 > /dev/null
function dependencies(){
echo -e ${PINK}
cat /etc/issue.net


echo "Verification du système " 
sleep 1
if [[ "$(ping -c 1 8.8.8.8 | grep '100% packet loss' )" != "" ]]; then
  echo ${RED}"Vous n'etes pas connecté à  internet"
  exit 1
  else
  echo -e ${GREEN} "\n[ ✔ ] Internet.............${GREEN}[ working ]"
fi
sleep 1
which curl > /dev/null 2>&1
if [ "$?" -eq "0" ]; then
echo -e ${GREEN} "\n[ ✔ ] curl.............${GREEN}[ found ]"
else
echo -e $red "[ X ] curl  -> ${RED}not found "
echo -e ${YELLOW} "[ ! ] Installation de curl "
sudo apt-get install curl
echo -e ${BLUE} "[ ✔ ] fait ...."
fi
sleep 1
which git > /dev/null 2>&1
if [ "$?" -eq "0" ]; then
echo -e ${GREEN} "\n[ ✔ ] git.............${GREEN}[ found ]"
else
echo -e $red "[ X ] git  -> ${RED}pas trouvé "
echo -e ${YELLOW} "[ ! ] Installation de  git "
pkg update && pkg upgrade  > /dev/null 2>&1
pkg install git > /dev/null 2>&1
echo -e ${BLUE} "[ ✔ ] Fait ...."
which git > /dev/null 2>&1
sleep 1
fi
sleep 1
}

function printmsg(){
echo  -e ${RED}" Entrain de quitter FAKESMS ... "
sleep 1
echo -e ${ORANGE}" A plus............."
exit
}

function instruction(){

echo -e ${YELLOW}"\n1. Le code du pays doit commencer par "+"\n"
sleep 0.5
echo -e ${BLUE}"2. Country Code Example: 243\n"
sleep 0.5
echo -e ${ORANGE}"3. Le numero de telephone ne doit pas contenir  0\n"
sleep 0.5
echo -e ${CNC}"4. Guide d'utilisation: 243810000000\n"
sleep 0.5
echo -e ${RED}" ..........REMARQUE: 1 seul SMS authorisé par jour...........\n"
sleep 0.5
echo -e -n ${BLUE}"\nRETOUR AUX OPTIONS SENDSMS: [OUI/NON]: "
read back_press
if [ $back_press = "oui"  ]; then
         SENDSMS
elif [ $back_press = "non" ]; then
              exit
     fi


}

function SENDSMS() {
    clear
    banner
    echo ""
   echo -e ${ORANGE}"Entrez votre numero de telephone (+24381000000000 par exemple)\n"
   echo -e -n ${CP}"Entrez le numero de telephone : "
   
   read num
   
   echo "  "
   echo -e -n ${BLUE}"Tapez votre message: "
   
   read msg


   SMSVERIFY=$(curl -# -X POST https://textbelt.com/text --data-urlencode phone="$num" --data-urlencode message="$msg" -d key=textbelt)
   
   if grep -q true <<<"$SMSVERIFY"
   
   then
      
      echo "  "
      echo -e ${CNC}" .....ENVOYE "
      echo "  "
      echo -e ${CNC}" ---------------------------------------------- "
      echo "$SMSVERIFY"
      echo -e ${CNC}" ---------------------------------------------- "
      echo "  "
      printmsg
   else
      
      echo "  "
      echo -e ${RED}" ECHEC "
      echo "  "
      echo -e ${CNC}" ---------------------------------------------- "
      echo "$SMSVERIFY"
      echo -e ${CNC}" ---------------------------------------------- "
      echo " "
      printmsg
   fi
}
function STATUSCHECK(){
echo -e -n ${ORANGE}"\nEntrez ID du text (e.g 123456): "
read ID
STATUSCONFIRM=$(curl -# https://textbelt.com/status/"$ID")
echo -e ${PINK}" REPONSE FINALE (JSON): "
   echo " "
   echo -e ${PINK}" ---------------------------------------------- $NC"
   echo "$STATUSCONFIRM"
   echo -e ${PINK}"------------------------------------------------- $NC"
}
trap ctrl_c INT
ctrl_c() {
clear
echo -e ${RED}"[*] (Ctrl + C ) Detecté entrain de quitter... "
echo -e ${RED}"[*] Arret des Services... "
sleep 1
echo ""
echo -e ${YELLOW}"[*] Merci d'avoir utilisé Fake-SMS  :)"
exit
}


menu(){

clear
dependencies
clear
banner


echo -e " \n${NC}[${CG}"1"${NC}]${CNC} VOIR USAGE "
echo -e "${NC}[${CG}"2"${NC}]${CNC} ENVOYER un Fake SMS"
echo -e "${NC}[${CG}"3"${NC}]${CNC} VERIFIER STATUS SMS "
echo -e "${NC}[${CG}"4"${NC}]${CNC} QUITTER "
echo -n -e ${RED}"\n[+] Selectioner: "
read play
   if [ $play -eq 1 ]; then
          instruction
   elif [ $play -eq 2 ]; then
          SENDSMS
   elif [ $play -eq 3 ]; then
          STATUSCHECK
   elif [ $play -eq 4 ]; then
          exit
         
      fi
}
menu
# Ecrit par b@shlore
