#!/bin/bash

runTest=0

while getopts ":v:m:t:" opt; do
  case $opt in
    v) version="$OPTARG"
    ;;
    m) message="$OPTARG"
    ;;
    t) runTest=1
    ;;
    \?) echo "Invalid option -$OPTARG" >&2
    ;;
  esac
done

if [ -z "$version" ]
then
  echo Mising version argument
  exit
fi

if [ -z "$message" ]
then
  echo Missing message argument
  exit
fi

echo Checking if tag $version exists...

git fetch

if git tag --list | egrep $version
then
  echo Tag $version already exist
  exit
fi

echo Checking out develop...
if [[ ! $(git checkout develop) ]]; then
  echo Can\'t checkout develop
  exit
fi 

echo Pulling develop...
if [[ ! $(git pull) ]]; then
  echo Can\'t pull develop
  exit
fi 

echo Checking out master...
if [[ ! $(git checkout master) ]]; then
  echo Can\'t checkout master
  exit
fi 
  
echo Pulling master...
if [[ ! $(git pull) ]]; then
  echo Can\'t pull master
  exit
fi
 
echo Merging develop-\>master... 
if  [[ ! $(git merge develop) ]]; then
  echo Can\'t merge develop-\>master
  exit
fi

if [[ $runTest -eq 1 ]]; then
  echo Running tests...
  valid="$(npm test | grep -o 'Error')"
    if [[ ! -z $valid ]]; then
      echo Tests are failing
      exit
    fi
fi

echo Building production lib...

#{ 
#npm run build-prod 
#} || {
#echo 1234



if [[ $(npm run build-prod) ]]; then
  git add .
  git commit -m "Production lib $version"
  git push 
  
  echo Creating tag $version
  git tag -a $version -m "$message"
  echo Pushing tag to origin
  git push origin $version

else
  echo Build-prod script failed
if

echo Done

