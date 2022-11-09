#!/bin/sh

remote_server=192.168.0.14
compose_path=docker-compose

rsync -avzr docker-compose.yml ${remote_server}:/tmp/

ssh ${remote_server} -t "cd /tmp; pwd; $compose_path down; $compose_path up --scale spark-worker=2"