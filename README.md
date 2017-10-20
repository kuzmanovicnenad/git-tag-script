# git-tag-script

Node:
For github repo use [master](https://github.com/kuzmanovicnenad/git-tag-script/tree/master)

For bitbucket repo use [bitbucket-repo](https://github.com/kuzmanovicnenad/git-tag-script/tree/bitbucket-repo)

## Example

```shell
./tag.sh -v v1.1.2 -m 'Bug fix' -t
```
## Parameters

__-v__ Tag (version)

__-m__ Tag message

__-t__ Start tests before build (optional)

## Usage

This script will:
* merge __develop__ branch to __master__
* start tests (npm test script is required if this option is set (-t))
* build prod lib (npm build-prod script is required)
* push changes to repo
* create new tag
* push tag to repo
