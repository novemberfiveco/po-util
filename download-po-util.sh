#!/bin/bash
blue_echo() {
    echo "$(tput setaf 4)$MESSAGE $(tput sgr0)"
}

green_echo() {
    echo "$(tput setaf 2)$MESSAGE $(tput sgr0)"
}

red_echo() {
    echo "$(tput setaf 1)$MESSAGE $(tput sgr0)"
}

if [ -f ~/po-util.sh ];
then
  rm ~/po-util.sh
  if [ -f po-util.sh ];
  then
      cp po-util.sh ~/po-util.sh
  else
  curl -fsSLO https://raw.githubusercontent.com/nrobinson2000/po-util/master/po-util.sh
  cp po-util.sh ~/po-util.sh
  chmod +x ~/po-util.sh
fi
else
  curl -fsSLO https://raw.githubusercontent.com/nrobinson2000/po-util/master/po-util.sh
  cp po-util.sh ~/po-util.sh
fi

if [ -f ~/.bash_profile ];
then
  MESSAGE=".bash_profile present." ; green_echo
else
MESSAGE="No .bash_profile present. Installing.." ; red_echo
echo "
export PATH=\"/usr/local/sbin:$PATH\"
if [ -f ~/.bashrc ]; then
    . ~/.bashrc
fi" >> ~/.bash_profile
fi

if [ -f ~/.bashrc ];
then
  MESSAGE=".bashrc present." ; green_echo
  if cat ~/.bashrc | grep "po-util.sh" ;
  then
    MESSAGE="po alias already in place." ; green_echo
  else
    MESSAGE="no po alias.  Installing..." ; red_echo
    echo 'alias po="~/po-util.sh"' >> ~/.bashrc
  fi
else
  MESSAGE="No .bashrc present.  Installing..." ; red_echo
  echo 'alias po="~/po-util.sh"' >> ~/.bashrc
fi

# ~/po-util.sh install && echo && MESSAGE="Sucessfully installed the Particle Offline Utility and necessary dependencies!" ; green_echo && echo "Read more at https://github.com/nrobinson2000/po-util" ; green_echo
