#!/bin/bash

MAVEN_TGZ_FILE=http://ftp.kddilabs.jp/infosystems/apache/maven/maven-3/3.0.4/binaries/apache-maven-3.0.4-bin.tar.gz

##########################################################################
# maven setup #
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
mkdir -p opt
mkdir -p $MAVEN_DIR

echo -e "\n\n pwd ~/bin; ls -la ~/bin \n"
pwd ~/bin; ls -la ~/bin
echo -e "\n\n"
}

##########################################################################
func_install_maven ()
{
cd $MAVEN_DIR
FL_NAM01=maven.tgz
wget $MAVEN_TGZ_FILE -O $FL_NAM01
tar zxvf $FL_NAM01
mv apache-maven-3* $M3_HOME
#mv maven_tmp/apache-maven-3* maven3
PATH=$M3_HOME/bin:$PATH
}

##########################################################################
func_mvn_sh ()
{
cd $HOME/bin

MVN_SH='#!/bin/sh

'M3_HOME=$M3_HOME'
PATH=$M3_HOME/bin:$PATH

#JAVA_HOME=/usr/local/java
#JAVA_HOME=$HOME/opt/java
#PATH=${JAVA_HOME}/bin:$PATH

sh $M3_HOME/bin/mvn $*
'
echo "$MVN_SH" > mvn
chmod 775 mvn
}

##########################################################################
func_mvn_local_sh_NG!!!!! ()
{
cd $HOME/bin

pwd
CP_CMD="cp -ipv $M3_HOME/conf/settings.xml ."
echo -e I will do command !!! : \"${CP_CMD}\"
${CP_CMD}

MVN_SH='#!/bin/sh

HERE=$(cd $(dirname $0);pwd);

'M3_HOME=$M3_HOME'
PATH=$M3_HOME/bin:$PATH

#JAVA_HOME=/usr/local/java
#JAVA_HOME=$HOME/opt/java
#PATH=${JAVA_HOME}/bin:$PATH

sh $M3_HOME/bin/mvn -s ${HOME}/bin/settings.xml $*
'
echo "$MVN_SH" > mvn_localsetting
chmod 775 mvn_localsetting
}

##########################################################################

#func_mkdirs
#func_install_maven
func_mvn_sh
#func_mvn_local_sh
