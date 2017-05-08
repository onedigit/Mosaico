#!/bin/bash
# workaround for a docker bug in aws
if ! grep 8.8.8.8 /etc/resolv.conf
then echo "nameserver 8.8.8.8" | sudo tee -a /etc/resolv.conf
fi
export SPARK_HOME=/usr/spark
export HADOOP_HOME=/usr/hadoop
export PATH=$HADOOP_HOME/bin:$SPARK_HOME/bin:$PATH
export SPARK_DIST_CLASSPATH=$(hadoop classpath)
cd /usr/spark
if test -z "$SPARK_MASTER"
then exec bin/spark-class org.apache.spark.deploy.master.Master
else exec bin/spark-class org.apache.spark.deploy.worker.Worker "$SPARK_MASTER"
fi
