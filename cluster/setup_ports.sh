#!/bin/bash

HOME=/mnt/pspd-lds/alunos/$(whoami)

BASEDIR=/mnt/pspd-lds/share
HADOOP_DIR=$BASEDIR/hadoop
SPARK_BIN_DIR=$BASEDIR/spark
NODES=($(cat $BASEDIR/nodes))

PORT_START=9000
PORT_END=10000

PROPERTY_PATTERN="s/(<property><name>%s<\/name><value>)([^<]*)(<\/value><\/property>)/\\\1%s\\\3/"
NAMENODE_ADDRESS="fs.default.name"
NAMENODE_DATA_DIR="dfs.namenode.name.dir"
DATANODE_DATA_DIR="dfs.datanode.data.dir"
NAMENODE_WEBUI_ADDRESS="dfs.namenode.http-address"
DATANODE_ADDRESS="dfs.datanode.address"
DATANODE_WEBUI_ADDRESS="dfs.datanode.http.address"
DATANODE_IPC_ADDRESS="dfs.datanode.ipc.address"
HADOOP_TMP_DIR="hadoop.tmp.dir"

PORTS=()

function print_div {
    printf -- "=%.0s" {1..80} && echo
}

function read_number {
    start=$1
    end=$2

    while true; do
        read number

        if [[ $number -ge $start ]] && [[ $number -le $end ]]; then
            break
        else
            >&2 echo "Número invalido. Digite um numbero entre $start e $end"
        fi
    done

    echo $number
}

function read_open_port {
    start=$1
    end=$2

    while true; do
        number=$(read_number $start $end)
        2> /dev/null </dev/tcp/localhost/$number
        if [[ $? -eq 0 ]]; then
            >&2 echo "A porta $number já esta em uso no momento. Escolha outra"
        else
            break
        fi
    done

    echo $number
}

function is_port_specified {
    for port in ${PORTS[@]}; do
        if [[ $port -eq $1 ]]; then
            >&2 echo "A porta $1 já foi especificada. Escolha outra"
            echo 1
            return
        fi
    done
    echo 0
}

function read_port {
    start=$1
    end=$2

    while true; do
        number=$(read_open_port $start $end)
        if [[ $(is_port_specified $number) -eq 0 ]]; then
            PORTS+=($number)
            echo $number
            return;
        fi
    done
}

function get_node_home {
    echo $HOME/$1
}

function get_node_core_site {
    echo $(get_node_home $1)/hadoop/etc/hadoop/core-site.xml
}

function get_node_hdfs_site {
    echo $(get_node_home $1)/hadoop/etc/hadoop/hdfs-site.xml
}

function get_node_spark_env_conf {
    echo $(get_node_home $1)/spark/conf/spark-env.sh
}

function replace_config {
    file=$1
    property=$2
    value=$(echo $3 | sed 's/\//\\\//g')
    regex=$(printf $PROPERTY_PATTERN $property $value)
    sed -i -E $regex $file
}

cd $HOME

print_div
echo "Configuração das portas do Hadoop e Spark"
echo "Os arquivos de configurações dos seguintes nós serao sobrescritas:"
echo ${NODES[@]}
print_div



for node in ${NODES[@]}; do
   cp $HADOOP_DIR/etc/hadoop/core-site.xml $(get_node_core_site $node)
   cp $HADOOP_DIR/etc/hadoop/hdfs-site.xml $(get_node_hdfs_site $node)

   hadoop_tmp_dir=$(get_node_home $node)/hadoop-tmp
   rm -r $hadoop_tmp_dir 2> /dev/null
   mkdir $hadoop_tmp_dir
   replace_config $(get_node_core_site $node) $HADOOP_TMP_DIR $hadoop_tmp_dir
done;

echo -e "\n\n"
print_div
echo "Namenode - digite a porta:"
print_div
port=$(read_open_port $PORT_START $PORT_END)

for node in ${NODES[@]}; do
    replace_config $(get_node_core_site $node) $NAMENODE_ADDRESS hdfs://${NODES[0]}:$port
    replace_config $(get_node_hdfs_site $node) $NAMENODE_DATA_DIR $(get_node_home $node)/data_namenode
    replace_config $(get_node_hdfs_site $node) $DATANODE_DATA_DIR $(get_node_home $node)/data_datanode
done;

echo -e "\n\n"
print_div
echo "Namenode Web UI - digite a porta:"
print_div
port=$(read_open_port $PORT_START $PORT_END)

for node in ${NODES[@]}; do
    replace_config $(get_node_hdfs_site $node) $NAMENODE_WEBUI_ADDRESS $node:$port
done;

echo -e "\n\n"
print_div
echo "Datanode - digite a porta:"
print_div
port=$(read_open_port $PORT_START $PORT_END)

for node in ${NODES[@]}; do
    replace_config $(get_node_hdfs_site $node) $DATANODE_ADDRESS $node:$port
done;

echo -e "\n\n"
print_div
echo "Datanode Web UI - digite a porta:"
print_div
port=$(read_open_port $PORT_START $PORT_END)

for node in ${NODES[@]}; do
    replace_config $(get_node_hdfs_site $node) $DATANODE_WEBUI_ADDRESS $node:$port
done;

echo -e "\n\n"
print_div
echo "Datanode IPC - digite a porta:"
print_div
port=$(read_open_port $PORT_START $PORT_END)

for node in ${NODES[@]}; do
    replace_config $(get_node_hdfs_site $node) $DATANODE_IPC_ADDRESS $node:$port
done;

echo -e "\n\n\n"
print_div
echo "Spark"
print_div

echo -e "\n\n"
print_div
echo "Spark Master - digite a porta:"
print_div
port=$(read_open_port $PORT_START $PORT_END)

for node in ${NODES[@]}; do
    cp $SPARK_BIN_DIR/conf/spark-env.sh $(get_node_spark_env_conf $node)
    echo "SPARK_MASTER_PORT=$port" >> $(get_node_spark_env_conf $node)
done;

echo -e "\n\n"
print_div
echo "Spark Master UI - digite a porta:"
print_div
port=$(read_open_port $PORT_START $PORT_END)

for node in ${NODES[@]}; do
    echo "SPARK_MASTER_WEBUI_PORT=$port" >> $(get_node_spark_env_conf $node)
done;

hadoop namenode -format
