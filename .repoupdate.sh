#!/usr/bin/env bash

echo -e "\n\e[1;33m==>\e[1;97m Initializing repos update process...\e[0;97m"
DIR_LIST=`find $HOME/SibSUTIS -maxdepth 1 -type d`  # Change -maxdepth argument to the value you need
UPD_REPO=0

ping -c2 -i0.2 8.8.8.8 >/dev/null 2>/dev/null
if [[ $? -eq 2 ]]; then
  echo -e "   \e[1;31mAn error with connection was occured... Exiting now...\e[0;97m\n"
  exit -1
fi

for DIR in ${DIR_LIST}; do
  if [ -e ${DIR}/.git ]; then
    cd ${DIR}
    echo -ne "   \e[1;34m-> \e[1;97m"$(pwd)'\t[#-----------------------] 1%\r'
    sleep 0.1
    echo -ne "   \e[1;34m-> \e[1;97m"$(pwd)'\t[######------------------] 25%\r'
    sleep 0.1
    echo -ne "   \e[1;34m-> \e[1;97m"$(pwd)'\t[############------------] 50%\r'

    git pull -q 2>/dev/null
    if [ $? -eq 0 ]; then
      UPD_REPO=$((${UPD_REPO} + 1))
      echo -ne "   \e[1;34m-> \e[1;97m"$(pwd)'\t[##################------] 75%\r'
      sleep 0.1
      echo -ne "   \e[1;34m-> \e[1;97m"$(pwd)'\t[########################] 100%'
      echo -ne '\n'
    else
      echo -ne "   \e[1;31m-> \e[1;97m"$(pwd)'\t[                        ] \e[1;31m???%'
      echo -ne '\n'
    fi
  else
    cd ${DIR}

    echo -ne "   \e[1;34m-> \e[1;97m"$(pwd)'\t\t[#-----------------------] 1%\r'
    sleep 0.1
    echo -ne "   \e[1;34m-> \e[1;97m"$(pwd)'\t\t[######------------------] 25%\r'
    sleep 0.1
    echo -ne "   \e[1;34m-> \e[1;97m"$(pwd)'\t\t[############------------] 50%\r'

    git pull -q 2>/dev/null
    if [ $? -eq 0 ]; then
      UPD_REPO=$((${UPD_REPO} + 1))
      echo -ne "   \e[1;34m-> \e[1;97m"$(pwd)'\t\t[##################------] 75%\r'
      sleep 0.1
      echo -ne "   \e[1;34m-> \e[1;97m"$(pwd)'\t\t[########################] 100%'
      echo -ne '\n'
    else
      echo -ne "   \e[1;31m-> \e[1;97m"$(pwd)'\t\t[                        ] \e[1;31m???%'
      echo -ne '\n'
    fi
  fi
done

if [ ${UPD_REPO} -gt 0 ]; then
  echo -e "\e[1;32m"${UPD_REPO} "repos were updated successfully...\e[0;97m\n"
else
  echo -e "\e[1;31m"${UPD_REPO} "repos were not updated...\e[0;97m\n"
fi
