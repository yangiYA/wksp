#!/bin/bash

GIT_USER_NAME=yangiYa
GIT_USER_EMAIL=empty@foo.foo

##########################################################################
# Git config setting
##########################################################################
func_git_config_sh ()
{
cd $HOME

git config --global user.name "$GIT_USER_NAME"
git config --global user.email "$GIT_USER_EMAIL"
git config --global color.ui auto
git config --global core.editor 'vim -c "set fenc=utf-8"'
git config --global core.autocrlf false
}
##########################################################################

##########################################################################
# "git diff" and "git merge" GUI tool setup #
##########################################################################
HERE=$(cd $(dirname $0);pwd)

cd $HERE
. ${HERE}/dev_path

echo -e "\n"
echo $HERE
echo ${HERE}/dev_path
echo $M2_HOME
echo -e "\n"

##########################################################################
func_mkdirs ()
{
cd $HOME
mkdir -p bin

echo -e "\n\n pwd ~/bin; ls -la ~/bin \n"
pwd ~/bin; ls -la ~/bin
echo -e "\n\n"
}

##########################################################################
func_git_extDiff_sh ()
{
cd $HOME/bin

GIT_EXT_SH='#!/bin/sh

# If there are seven arguments, new file and old file will be passed to an argument. 
[ $# -eq 7 ] && meld "$2" "$5"
'
echo "$GIT_EXT_SH" > extDiff.sh
chmod 775 extDiff.sh


# set the settings under to the file "~/.gitconfig" .
#[merge]
#  tool = extMerge
#[mergetool "extMerge"]
#  cmd = meld "$BASE" "$LOCAL" "$REMOTE" "$MERGED"
#  trustExitCode = false
#[diff]
#  external = extDiff.sh
cd $HOME

git config --global merge.tool "extMerge"
git config --global mergetool.extMerge.cmd 'meld "$BASE" "$LOCAL" "$REMOTE" "$MERGED"'
git config --global mergetool.extMerge.trustExitCode false
git config --global diff.external extDiff.sh
}

##########################################################################

##########################################################################
# winmerge to meld shell pretend
##########################################################################
func_dummy_meld_sh ()
{
cd $HOME/bin

MELD_SH='#!/bin/sh

WINMERGE_PATH=/c/programs/editor/WinMerge/WinMergeU
${WINMERGE_PATH} $*

'

echo "$MELD_SH" > meld
chmod 775 meld
}
##########################################################################





func_git_config_sh
func_mkdirs
func_git_extDiff_sh

# for windows mingw shell
#func_dummy_meld_sh

