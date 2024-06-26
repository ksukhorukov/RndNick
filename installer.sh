# Copyright 2024 KIRILL SUKHORUKOV

# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.

# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.

# You should have received a copy of the GNU General Public License V.3
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

#!/usr/bin/env bash

PURPLE='\033[0;35m' 
RED='\033[0;31m' 
BLUE='\033[0;34m' 
WHITE='\033[0;37m' 
GREEN='\033[0;32m'  

PROFILE_FILE='UNDEFINED'

MAJOR_VERSION_PART_REQUIRED=3

out() {
  echo "$PURPLE $1"
}

info() {
  echo "$BLUE $1"
}

white() {
  echo "$WHITE $1"
}

success() {
  echo "$GREEN $1"
}

error() {
  echo "$RED $1"
  exit
}

make_shell_profile() {
  export PROFILE_FILE="$HOME/.$1"
}

RUBY_INTERPRETATOR_LOCATION=`which ruby`

if [ -z $RUBY_INTERPRETATOR_LOCATION ]; then
  echo "\n"
  error '[-] ERROR! Ruby interpretator is not installed'
  exit
else 
  echo "\n"
  out '[+] Perfect. You have some Ruby installed...'
fi

RUBY_VERSION=`ruby -v | awk '{print $2}'`

MAJOR_VERSION_PART=`echo "$RUBY_VERSION" | cut -d. -f1`

if [[ $MAJOR_VERSION_PART -ne $MAJOR_VERSION_PART_REQUIRED ]]; then
  error "[-] ERROR! Ruby version mismatch. Minimal Ruby version $MAJOR_VERSION_PART_REQUIRED"   
  exit
fi 

out "[+] Script can be installed. Your Ruby version is $RUBY_VERSION"

BUNDLER_LOCATION=`which bundler`

if [ -z $BUNDLER_LOCATION ]; then
  info '[~] Installing bundler...'
  gem install bundler
else 
  out '[+] Bundler already installed'
fi
  
out '[+] Installing gems...'

bundle install

CURRENT_DIRECTORY=`pwd`
CURRENY_SHELL=`echo -e $SHELL`

BASH_PROFILE_FILE='bashrc' 
MAC_PROFILE_FILE='zshrc'
FREEBSD_PROFILE_FILE='tcshrc' 
OPENBSD_PROFILE_FILE='kshrc'

CURRENT_DIRECTORY=`pwd`

if [ -f "$HOME/.$BASH_PROFILE_FILE" ]; then
  make_shell_profile "$BASH_PROFILE_FILE"
fi

if [ -f "$HOME/.$MAC_PROFILE_FILE" ]; then
  make_shell_profile "$MAC_PROFILE_FILE"
fi

if [ -f "$HOME/.$FREEBSD_PROFILE_FILE" ]; then 
  make_shell_profile "$FREEBSD_PROFILE_FILE" 
fi

if [ -f "$HOME/.$OPENBSD_PROFILE_FILE" ]; then 
  make_shell_profile "$OPENBSD_PROFILE_FILE"
fi

out '[+] Adding rndnick to the loadpaths...'

NEW_PATH="export PATH=\"\$PATH:$CURRENT_DIRECTORY/\""

echo "$NEW_PATH" >> $PROFILE_FILE

success '[+] Success!'

success "\n\n\t\t\tuse 'rndnick' to run the programm\n"

info "Important! Use the following command to reload rc file: \`source $PROFILE_FILE\` or reopen the terminals\n"