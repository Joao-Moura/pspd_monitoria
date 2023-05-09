#!/bin/bash

BASEDIR=/mnt/pspd-lds/share
NODES=($(cat $BASEDIR/nodes))

HADOOP_BIN_DIR=$BASEDIR/hadoop
SPARK_BIN_DIR=$BASEDIR/spark

JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64

HOME=/mnt/pspd-lds/alunos/$(whoami)
bashrc=$HOME/.bashrc


function setup_node_hadoop() {
    for node in ${NODES[@]}; do
        hadoop_node=$HOME/$node/hadoop

        mkdir -p $hadoop_node

        ln -s -r $HADOOP_BIN_DIR/* $hadoop_node
        rm -r $hadoop_node/etc
        cp -r $HADOOP_BIN_DIR/etc $hadoop_node

        echo "export JAVA_HOME=$JAVA_HOME" >> $hadoop_node/etc/hadoop/hadoop-env.sh
        echo "export HADOOP_HOME=$HOME/\$HOSTNAME/hadoop" >> $hadoop_node/etc/hadoop/hadoop-env.sh
	echo "export HADOOP_CONF_DIR=\$HADOOP_HOME/etc/hadoop" >> $hadoop_node/etc/hadoop/hadoop-env.sh
	echo "export HADOOP_HDFS_HOME=\$HADOOP_HOME" >> $hadoop_node/etc/hadoop/hadoop-env.sh
	echo "export HADOOP_YARN_HOME=\$HADOOP_HOME" >> $hadoop_node/etc/hadoop/hadoop-env.sh
    done;
}

function setup_node_spark() {
    for node in ${NODES[@]}; do
        spark_node=$HOME/$node/spark
    
        mkdir -p $spark_node

        ln -s -r $SPARK_BIN_DIR/* $spark_node
        rm -r $spark_node/conf
        mkdir $spark_node/conf
        cp $SPARK_BIN_DIR/conf/* $spark_node/conf/
    done;
}

function update_bashrc() {
    touch $bashrc

    mkdir -p $HOME/$HOSTNAME

    echo "export HOME=$HOME/\$HOSTNAME" >> $bashrc
    echo "export JAVA_HOME=$JAVA_HOME" >> $bashrc
    echo "export HADOOP_HOME=\$HOME/hadoop" >> $bashrc
    echo "export HADOOP_INSTALL=\$HADOOP_HOME" >> $bashrc
    echo "export HADOOP_MAPRED_HOME=\$HADOOP_HOME" >> $bashrc
    echo "export HADOOP_COMMON_HOME=\$HADOOP_HOME" >> $bashrc
    echo "export HADOOP_HDFS_HOME=\$HADOOP_HOME" >> $bashrc
    echo "export HADOOP_CONF_DIR=\$HADOOP_HOME/etc/hadoop" >> $bashrc
    echo "export YARN_HOME=\$HADOOP_HOME" >> $bashrc
    echo "export HADOOP_COMMON_LIB_NATIVE_DIR=\$HADOOP_HOME/lib/native" >> $bashrc
    echo "export SPARK_HOME=\$HOME/spark" >> $bashrc
    echo "export PATH=\$PATH:\$HADOOP_HOME/sbin:\$HADOOP_HOME/bin:\$JAVA_HOME:\$SPARK_HOME" >> $bashrc
    echo "cd \$HOME" >> $bashrc
}

function add_close_hadoop_in_ssh_logout() {
    bash_logout=$HOME/.bash_logout

    touch $bash_logout

    echo "bash /mnt/pspd-lds/share/hadoop/sbin/stop-all.sh" >> $bash_logout
}

cd $HOME
setup_node_hadoop
setup_node_spark
update_bashrc
add_close_hadoop_in_ssh_logout
source .bashrc
ssh ${NODES[0]}

