#!/bin/bash

version=$1

if [ -z "$version"]
then
  echo Mising version argument
  exit 1
fi

echo Checking if tag $version exists...
if git tag --list | egrep $1 
then
  echo Tag $version already exist
else
  git checkout develop
  git pull
  git checkout master
  git pull
fi


echo done

