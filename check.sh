#! /bin/bash

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
which -s ruby
if [[ $? != 0 ]] ; then
  # Install Homebrew
  p_warn "Ruby not found"
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
which -s gem
if [[ $? != 0 ]] ; then
  # Install Homebrew
  p_warn "rubygems not found"
  #/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
else
  #brew update
  gem_version=`gem -v`
  p_success "RubyGems: $gem_version"
fi