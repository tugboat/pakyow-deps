#! /bin/bash

deps_met=true

function p_success {
  message=$1

  tput setaf 2
  echo $1
  tput sgr0
}

function p_warn {
  message=$1

  tput setaf 3
  echo $1
  tput sgr0
}

echo "Determining the underlying operating system"

unamestr=`uname`
if [[ "$unamestr" == 'Linux' ]]; then
  platform='linux'
elif [[ "$unamestr" == 'FreeBSD' ]]; then
  platform='freebsd'
elif [[ "$unamestr" == 'Darwin' ]]; then
  platform='osx'
fi

echo "Looks like you're running $platform"

# Let's handle the OSX case first

# First thing we need is ruby.
#
# Check if Ruby is installed
#
which ruby > /dev/null
if [[ $? != 0 ]] ; then
  # Install Homebrew
  p_warn "Ruby not found"
  deps_met=false
  #/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
else
  #brew update
  ruby_version=`ruby -v`
  p_success "Ruby: $ruby_version"
fi

# Next thing we need is rubygems.
#
# Check if Gem is installed
#
which gem > /dev/null
if [[ $? != 0 ]] ; then
  # Install Homebrew
  p_warn "rubygems not found"
  deps_met=false
  #/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
else
  #brew update
  gem_version=`gem -v`
  p_success "RubyGems: $gem_version"
fi

if [[ "$deps_met" == true ]]; then
  # Check if pakyow is already is installed
  gem list pakyow -i > /dev/null
  if [[ $? != 0 ]] ; then
    echo "Looks like you are all set type 'gem install pakyow' to get started"
  else
    echo "Looks like you are all set and have pakyow installed, type 'pakyow new' to get started building your app"
  fi
fi
