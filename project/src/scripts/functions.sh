#!/bin/bash
##########################################3

CUR_DIR="$(dirname "$0")"
source $CUR_DIR/paths.sh

function getFileRisc(){
  D=$1
  echo "${RISC_PATH}/RF.${D}.nc.tif"
}

function getFilePrec(){
  D=$1
  echo "${PREC_PATH}/S10648241_${D}1200.nc.tif"
}
function getFileTemp(){
  D=$1
  echo "${TEMP_PATH}/${D}.nc.tk2m.tif"
}

function getFileUmid(){
  D=$1
  echo "${UMID_PATH}/${D}.nc.ur2m.tif"
}

function getFileUmid(){
  D=$1
  echo "${UMID_PATH}/${D}.nc.ur2m.tif"
}

function getFileLC8Raw(){
  D=$(date -d"$1" +%Y%j)
  ORBITA=$2
  PONTO=$3
  BAND=$4
  echo "${LC8_RAW_PATH}/LC8${ORBITA}${PONTO}${D}LGN00_${BAND}.TIF"
}

function getFileLC8Indices(){
  D=$(date -d"$1" +%Y-%m-%d)
  ORBITA=$2
  PONTO=$3
  INDICE=$4
  echo "${LC8_INDICES_PATH}/${ORBITA}_${PONTO}_${D}_${INDICE}.tif"
}

function getFileLC8Clouds(){
  D=$(date -d"$1" +%Y-%m-%d)
  ORBITA=$2
  PONTO=$3
  echo "${LC8_CLOUDS_PATH}/${ORBITA}_${PONTO}_${D}_nuvem.tif"
}

function getFileLC8Reflec(){
  D=$(date -d"$1" +%Y-%m-%d)
  ORBITA=$2
  PONTO=$3
  BAND=$4
  echo "${LC8_REFLEC_PATH}/${ORBITA}_${PONTO}_${D}_ref_${BAND}.tif"
}

#echo "Functions loaded"
