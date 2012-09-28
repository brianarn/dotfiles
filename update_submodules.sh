#!/bin/sh
echo 'Updating all submodules to master branch...'
git submodule foreach 'git checkout master && git pull origin master'
echo 'Done!'
