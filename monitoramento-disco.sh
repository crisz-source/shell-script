#!/bin/bash


ponto_montagem="/mnt/c"
nome_log=$(date +%F-%H:%M)
diretorio=$(pwd)

uso_disco=$(df -h | grep $ponto_montagem | awk '{print $5}')
echo "uso de disco em $uso_disco" > "$diretorio/$nome_log.log"

