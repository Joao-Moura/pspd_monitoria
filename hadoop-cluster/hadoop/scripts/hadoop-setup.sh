#!/bin/bash

HADOOP_USER_HOME=/home/hadoop
HOME=$HADOOP_USER_HOME/student

# nodes=("cm1" "cm2" "cm3" "cm4" "gpu1" "gpu2" "gpu3")
nodes=("hadoop1" "hadoop2")
bashrc=$HOME/.bashrc
hadoop_bin=$HADOOP_USER_HOME/hadoop-bin


function setup_node_hadoop() {
    for node in ${nodes[@]}; do
        hadoop_node=$HOME/$node/hadoop

        mkdir -p $hadoop_node

        ln -s -r $hadoop_bin/* $hadoop_node
        rm -r $hadoop_node/etc
        cp -r $hadoop_bin/etc $hadoop_node

        echo "export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64" >> $hadoop_node/etc/hadoop-env.sh
    done;
}

function update_bashrc() {
    touch $bashrc

    mkdir -p $HOME/$HOSTNAME

    echo "export HOME=\$HOME/\$HOSTNAME" >> $bashrc
    echo "export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64" >> $bashrc
    echo "export HADOOP_HOME=\$HOME/hadoop" >> $bashrc
    echo "export HADOOP_INSTALL=\$HADOOP_HOME" >> $bashrc
    echo "export HADOOP_MAPRED_HOME=\$HADOOP_HOME" >> $bashrc
    echo "export HADOOP_COMMON_HOME=\$HADOOP_HOME" >> $bashrc
    echo "export HADOOP_HDFS_HOME=\$HADOOP_HOME" >> $bashrc
    echo "export YARN_HOME=\$HADOOP_HOME" >> $bashrc
    echo "export HADOOP_COMMON_LIB_NATIVE_DIR=\$HADOOP_HOME/lib/native" >> $bashrc
    echo "export PATH=\$PATH:\$HADOOP_HOME/sbin:\$HADOOP_HOME/bin:\$JAVA_HOME" >> $bashrc
    echo "cd \$HOME" >> $bashrc
}

function add_close_hadoop_in_ssh_logout() {
    bash_logout=$HOME/.bash_logout

    touch $bash_logout

    echo "bash $hadoop_bin/sbin/stop-all.sh" >> $bash_logout
}

setup_node_hadoop
update_bashrc
add_close_hadoop_in_ssh_logout
source .bashrc
