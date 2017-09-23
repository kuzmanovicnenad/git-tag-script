#!/bin/bash

version=$1

if [ -z "$version" ]
then
  echo Mising version argument
  exit
fi

echo Checking if tag $version exists...

git fetch

if git tag --list | egrep $version
then
  echo Tag $version already exist
else
  echo Checking out develop...
  if [[ ! $(git checkout develop) ]]; then
    echo Can\'t checkout develop
    exit
  else 
    echo Pulling develop...
    if [[ ! $(git pull) ]]; then
      echo Can\'t pull develop
      exit
    else 
    echo Checking out master...
    if [[ ! $(git checkout master) ]]; then
      echo Can\'t checkout master
      exit
    else 
    echo Pulling master...
    if [[ ! $(git pull) ]]; then
      echo Can\'t pull master
      exit
    else 
    echo Merging develop-\>master... 
    if  [[ ! $(git merge develop) ]]; then
      echo Can\'t merge develop-\>master
      exit
    else
    echo Creating tag $version ...
    git tag -a $version -m '$version'
    echo Pushing tag to origin... 
    git push origin $version

  fi fi fi fi fi
fi

echo done

