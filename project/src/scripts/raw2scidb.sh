#!/bin/bash

#
# Este escript faz a carga de arquivos raw para o scidb
#
LOG_FILE=$(date +%Y%m%d_%S.log)
exec >> $LOG_FILE 2>&1

# Cada arquivo representa um t e deve estar ordenado por nome

RAW_DIR="/home/scidb/Data/queimadas/scidb"
ARRAY_1D="rpth_1d"
ARRAY_3D="rpth"
ARRAY_ATTR="<risk:float,precipitation:float,temperature:float,humidity:float>"
ARRAY_TYPES="(float,float,float,float)"
ARRAY_1D_DIM="[i=0:1679999:0:1680000]"
ARRAY_3D_DIM="[col_id=0:1199:0:50;row_id=0:1399:0:50,time_id=0:365:0:366]"


iquery -a -q "create array ${ARRAY_3D} ${ARRAY_ATTR} ${ARRAY_3D_DIM}"
TIME=0
START_TIME_ALL=$(date +%s)
for FILE in `ls ${RAW_DIR}/*.scidb | sort -V`; do
   START_TIME=$(date +%s)
   echo "Iniciando inserção de ${FILE}"
   # 1. Carregando no SciDB array 1D
    echo "1. Carregandono SciDB array 1D ..."
    echo "Criando  array 1D ..."
    # 3.1 cria array
    iquery -a -q "create array ${ARRAY_1D} ${ARRAY_ATTR} ${ARRAY_1D_DIM};"

    #  3.2 carrega arquivo
    echo "Carregando arquivo ..."
    iquery -a -q "set no fetch; load(${ARRAY_1D},'$FILE',-2,'${ARRAY_TYPES}')";

    # 4. Converte 1D em 3D
    echo "Convertendo 1D em 3D (T=${TIME})... "
    iquery -a -q "set no fetch; insert(redimension(apply(${ARRAY_1D}, col_id, i%1200, row_id, i/1200, time_id, ${TIME}), ${ARRAY_3D}), ${ARRAY_3D});"

    # 4.1 removendo array 1D
    echo "Removendo array 1D ..."
    iquery -a -q "remove(${ARRAY_1D});"
    END_TIME=$(date +%s)
    DIF_TIME=`expr $END_TIME - $START_TIME`
    echo "Finalizado T=${TIME} em $DIF_TIME s\n\n"
    TIME=$((TIME+1))

done;

END_TIME_ALL=$(date +%s)
DIF_TIME=`expr $END_TIME_ALL - $START_TIME_ALL`
echo "Finalizado em $DIF_TIME s\n\n"
