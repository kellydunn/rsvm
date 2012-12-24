#!/bin/bash

RSVM_TARGET="$HOME/.rsvm"

if [ -d "$RSVM_TARGET" ]; then
  echo "=> RSVM is already installed in $RSVM_TARGET, trying to update"
  echo -ne "\r=> "
  cd $RSVM_TARGET && git pull
  exit
fi

# Cloning to $RSVM_TARGET
git clone git://github.com/sdepold/rsvm.git $RSVM_TARGET

echo

# Detect profile file, .bash_profile has precedence over .profile
if [ ! -z "$1" ]; then
  PROFILE="$1"
else
  if [ -f "$HOME/.bash_profile" ]; then
    PROFILE="$HOME/.bash_profile"
  elif [ -f "$HOME/.profile" ]; then
    PROFILE="$HOME/.profile"
  fi
fi

SOURCE_STR="PATH=\$PATH:$RSVM_TARGET/dist:$RSVM_TARGET/current/dist/bin"

if [ -z "$PROFILE" ] || [ ! -f "$PROFILE" ] ; then
  if [ -z $PROFILE ]; then
    echo "=> Profile not found"
  else
    echo "=> Profile $PROFILE not found"
  fi

  echo "=> Append the following line to the correct file yourself"
  echo
  echo -e "\t$SOURCE_STR"
  echo
  echo "=> Close and reopen your terminal to start using RSVM"
  exit
fi

if ! grep -qc "$RSVM_TARGET" $PROFILE; then
  echo "=> Appending source string to $PROFILE"
  echo $SOURCE_STR >> "$PROFILE"
else
  echo "=> Source string already in $PROFILE"
fi

echo "=> Close and reopen your terminal to start using RSVM"
