#!/bin/bash

SCALA_TGZ_FILE=http://www.scala-lang.org/downloads/distrib/files/scala-${SCALA_VER}.tgz
SBT_LAUNCH_JAR=http://typesafe.artifactoryonline.com/typesafe/ivy-releases/org.scala-sbt/sbt-launch/0.12.0/sbt-launch.jar

##########################################################################
# scala setup #
##########################################################################
HERE=$(cd $(dirname $0);pwd)

cd $HERE
. ${HERE}/dev_path

echo -e "\n"
echo $HERE
echo ${HERE}/dev_path
echo $SCALA_HOME
echo -e "\n"


func_install_sbt ()
{
cd $HOME/bin
if [ ! -e sbt-launch.jar ]; then
 wget $SBT_LAUNCH_JAR -O sbt-launch.jar
fi

SBT_SH=`cat <<'_EOS_'
#!/bin/bash

HERE=$(cd $(dirname $0);pwd);
java -Xmx512M -jar $HERE/sbt-launch.jar "$@"
_EOS_
`
echo "$SBT_SH" > sbt
chmod 775 sbt


REPL_SH=`cat <<'_EOS_'
#!/bin/bash

HERE=$(cd $(dirname $0);pwd);
java -Xmx512M \
 -Dsbt.main.class=sbt.ConsoleMain \
 -Dfile.encoding=UTF8 \
 -Dsbt.boot.directory=$HOME/.sbt/boot \
 -jar $HERE/sbt-launch.jar \
 "$@"
_EOS_
`
echo "$REPL_SH" > repl
chmod 775 repl
}

func_mkdirs ()
{
cd $HOME
mkdir -p opt
mkdir -p opt/scala

echo -e "\n\n pwd ~/bin; ls -la ~/bin \n"
pwd ~/bin; ls -la ~/bin
echo -e "\n\n"
}

func_install_scala ()
{
cd $HOME/opt/scala
wget $SCALA_TGZ_FILE -O scala.tgz
tar zxvf scala.tgz
$PATH=${SCALA_HOME}/bin:$PATH
}

func_install_sbt
func_mkdirs
#func_install_scala
