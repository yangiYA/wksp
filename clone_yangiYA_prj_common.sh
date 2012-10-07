#!/bin/bash

PRJ_NAME=$1

##########################################################################
# gitHUB yangiYA Project clone #
##########################################################################
HERE=$(cd $(dirname $0);pwd)

cd $HERE
git clone git@github.com:yangiYA/${PRJ_NAME}.git
#If you want read only.
#git clone git://github.com/yangiYA/${PRJ_NAME}.git

echo -e "\n\necho ${PRJ_NAME}/.git/config \n"
cat ${PRJ_NAME}/.git/config
echo -e "\n"
