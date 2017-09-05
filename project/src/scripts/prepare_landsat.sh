#!/bin/bash

#
# Este escript prepara os dados de risco_queimada, temperatura, umidade e precipitação para inserção no scidb
#

# APPs
TIFF2RAW="/home/vconrado/Documents/doutorado/disciplinas/CAP-386/vconrado/cap-386/project/src/tiff-to-raw/tifftoraw"
#TIFF2RAW="/bin/echo"
INTERLEAVER="/home/vconrado/Documents/doutorado/disciplinas/CAP-386/vconrado/cap-386/project/src/interleaver/interleaver"

CUR_DIR="$(dirname "$0")"
source $CUR_DIR/functions.sh


if [[ ! -d "${OUT_PATH}" ]]; then
  mkdir -p "${OUT_PATH}"
fi

if [[ ! -d "${TMP_PATH}" ]]; then
  mkdir -p "${TMP_PATH}"
fi

ORBITA="221"
PONTO="074"
#  01:00 para evitar problema com horário de verao
# Fonte: https://unix.stackexchange.com/a/316701
START_DATE=$(date -d "2016-01-11 01:00" +%s)
#DAYS=23
DAYS=1
NEXT=1382400 # 1382400 is 16 days
for ((EPOCH=START_DATE; EPOCH < START_DATE + DAYS*NEXT; EPOCH+=NEXT )); do

  DATE=$(date -d"@$EPOCH" +%Y%m%d)


  LC8_B1=$(getFileLC8Raw $DATE $ORBITA $PONTO "B1")
  LC8_B2=$(getFileLC8Raw $DATE $ORBITA $PONTO "B2")
  LC8_B3=$(getFileLC8Raw $DATE $ORBITA $PONTO "B3")
  LC8_B4=$(getFileLC8Raw $DATE $ORBITA $PONTO "B4")
  LC8_B5=$(getFileLC8Raw $DATE $ORBITA $PONTO "B5")
  LC8_B6=$(getFileLC8Raw $DATE $ORBITA $PONTO "B6")
  LC8_B7=$(getFileLC8Raw $DATE $ORBITA $PONTO "B7")
  LC8_B8=$(getFileLC8Raw $DATE $ORBITA $PONTO "B8")
  LC8_B9=$(getFileLC8Raw $DATE $ORBITA $PONTO "B9")
  LC8_B10=$(getFileLC8Raw $DATE $ORBITA $PONTO "B10")
  LC8_B11=$(getFileLC8Raw $DATE $ORBITA $PONTO "B11")
  LC8_BQA=$(getFileLC8Raw $DATE $ORBITA $PONTO "BQA")

  LC8_NDVI=$(getFileLC8Indices $DATE $ORBITA $PONTO "ndvi")
  LC8_NBRL=$(getFileLC8Indices $DATE $ORBITA $PONTO "nbrl")

  LC8_CLOUDS=$(getFileLC8Clouds $DATE $ORBITA $PONTO)

  LC8_REFLEC_B2=$(getFileLC8Reflec $DATE $ORBITA $PONTO "B2")
  LC8_REFLEC_B3=$(getFileLC8Reflec $DATE $ORBITA $PONTO "B3")
  LC8_REFLEC_B4=$(getFileLC8Reflec $DATE $ORBITA $PONTO "B4")
  LC8_REFLEC_B5=$(getFileLC8Reflec $DATE $ORBITA $PONTO "B5")
  LC8_REFLEC_B6=$(getFileLC8Reflec $DATE $ORBITA $PONTO "B6")
  LC8_REFLEC_B7=$(getFileLC8Reflec $DATE $ORBITA $PONTO "B7")

  #
  RAW_LC8_B1="$TMP_PATH/$(basename $LC8_B1).raw"
  RAW_LC8_B2="$TMP_PATH/$(basename $LC8_B2).raw"
  RAW_LC8_B3="$TMP_PATH/$(basename $LC8_B3).raw"
  RAW_LC8_B4="$TMP_PATH/$(basename $LC8_B4).raw"
  RAW_LC8_B5="$TMP_PATH/$(basename $LC8_B5).raw"
  RAW_LC8_B6="$TMP_PATH/$(basename $LC8_B6).raw"
  RAW_LC8_B7="$TMP_PATH/$(basename $LC8_B7).raw"
  RAW_LC8_B8="$TMP_PATH/$(basename $LC8_B8).raw"
  RAW_LC8_B9="$TMP_PATH/$(basename $LC8_B9).raw"
  RAW_LC8_B10="$TMP_PATH/$(basename $LC8_B10).raw"
  RAW_LC8_B11="$TMP_PATH/$(basename $LC8_B11).raw"
  RAW_LC8_BQA="$TMP_PATH/$(basename $LC8_BQA).raw"

  RAW_LC8_NDVI="$TMP_PATH/$(basename $LC8_NDVI).raw"
  RAW_LC8_NBRL="$TMP_PATH/$(basename $LC8_NBRL).raw"

  RAW_LC8_CLOUDS="$TMP_PATH/$(basename $LC8_CLOUDS).raw"

  RAW_LC8_REFLEC_B2="$TMP_PATH/$(basename $LC8_REFLEC_B2).raw"
  RAW_LC8_REFLEC_B3="$TMP_PATH/$(basename $LC8_REFLEC_B3).raw"
  RAW_LC8_REFLEC_B4="$TMP_PATH/$(basename $LC8_REFLEC_B4).raw"
  RAW_LC8_REFLEC_B5="$TMP_PATH/$(basename $LC8_REFLEC_B5).raw"
  RAW_LC8_REFLEC_B6="$TMP_PATH/$(basename $LC8_REFLEC_B6).raw"
  RAW_LC8_REFLEC_B7="$TMP_PATH/$(basename $LC8_REFLEC_B7).raw"


  OUT_FILE="${BASE_PATH}/landsat8/${DATE}.lc8.scidb"

  $TIFF2RAW $LC8_B1 $RAW_LC8_B1 /dev/null
  $TIFF2RAW $LC8_B2 $RAW_LC8_B2 /dev/null
  $TIFF2RAW $LC8_B3 $RAW_LC8_B3 /dev/null
  $TIFF2RAW $LC8_B4 $RAW_LC8_B4 /dev/null
  $TIFF2RAW $LC8_B5 $RAW_LC8_B5 /dev/null
  $TIFF2RAW $LC8_B6 $RAW_LC8_B6 /dev/null
  $TIFF2RAW $LC8_B7 $RAW_LC8_B7 /dev/null
  $TIFF2RAW $LC8_B8 $RAW_LC8_B8 /dev/null
  $TIFF2RAW $LC8_B9 $RAW_LC8_B9 /dev/null
  $TIFF2RAW $LC8_B10 $RAW_LC8_B10 /dev/null
  $TIFF2RAW $LC8_B11 $RAW_LC8_B11 /dev/null
  $TIFF2RAW $LC8_BQA $RAW_LC8_BQA /dev/null

  $TIFF2RAW $LC8_NDVI $RAW_LC8_NDVI /dev/null
  $TIFF2RAW $LC8_NBRL $RAW_LC8_NBRL /dev/null

  $TIFF2RAW $LC8_CLOUDS $RAW_LC8_CLOUDS /dev/null

  $TIFF2RAW $LC8_REFLEC_B2 $RAW_LC8_REFLEC_B2 /dev/null
  $TIFF2RAW $LC8_REFLEC_B3 $RAW_LC8_REFLEC_B3 /dev/null
  $TIFF2RAW $LC8_REFLEC_B4 $RAW_LC8_REFLEC_B4 /dev/null
  $TIFF2RAW $LC8_REFLEC_B5 $RAW_LC8_REFLEC_B5 /dev/null
  $TIFF2RAW $LC8_REFLEC_B6 $RAW_LC8_REFLEC_B6 /dev/null
  $TIFF2RAW $LC8_REFLEC_B7 $RAW_LC8_REFLEC_B7 /dev/null

  # junta arquivos
  $INTERLEAVER $OUT_FILE $RAW_LC8_B1 2 $RAW_LC8_B2 2 $RAW_LC8_B3 2 $RAW_LC8_B4 2 $RAW_LC8_B5 2 $RAW_LC8_B6 2 $RAW_LC8_B7 2 $RAW_LC8_B8 2 $RAW_LC8_B9 2 $RAW_LC8_B10 2 $RAW_LC8_B11 2 $RAW_LC8_BQA 2  $RAW_LC8_NDVI 4  $RAW_LC8_NBRL 4  $RAW_LC8_CLOUDS 4  $RAW_LC8_REFLEC_B2 4 $RAW_LC8_REFLEC_B3 4 $RAW_LC8_REFLEC_B4 4 $RAW_LC8_REFLEC_B5 4 $RAW_LC8_REFLEC_B6 4 $RAW_LC8_REFLEC_B7 4

  # apaga arquivos brutos
  #rm $RAW_LC8_B1 $RAW_LC8_B2 $RAW_LC8_B3 $RAW_LC8_B4 $RAW_LC8_B5 $RAW_LC8_B6 $RAW_LC8_B7 $RAW_LC8_B8 $RAW_LC8_B9 $RAW_LC8_B10 $RAW_LC8_B11 $RAW_LC8_BQA  $RAW_LC8_NDVI $RAW_LC8_NBRL  $RAW_LC8_CLOUDS  $RAW_LC8_REFLEC_B2 $RAW_LC8_REFLEC_B3 $RAW_LC8_REFLEC_B4 $RAW_LC8_REFLEC_B5 $RAW_LC8_REFLEC_B6 $RAW_LC8_REFLEC_B7
done

#date -d "2016-01-02 + 2 days" +"%m-%d-%Y"
