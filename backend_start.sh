#! /bin/bash
/opt/zookeeper-3.4.10/bin/zkServer.sh Start &
sleep 100
/opt/zookeeper-3.4.10/bin/zkCli.sh &
sleep 100
/opt/kafka_2.11-0.9.0.0/bin/kafka-server-start.sh /opt/kafka_2.11-0.9.0.0/config/properties &
sleep 100