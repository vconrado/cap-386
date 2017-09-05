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






#  01:00 para evitar problema com horário de verao
# Fonte: https://unix.stackexchange.com/a/316701
START_DATE=$(date -d "2016-01-01 01:00" +%s)
DAYS=366
NEXT=86400 # 86400 is one day
for ((EPOCH=START_DATE; EPOCH < START_DATE + DAYS*NEXT; EPOCH+=NEXT )); do

  DATE=$(date -d"@$EPOCH" +%Y%m%d)

  RISC=$(getFileRisc $DATE)
  PREC=$(getFilePrec $DATE)
  TEMP=$(getFileTemp $DATE)
  UMID=$(getFileUmid $DATE)
  #
  RAW_RISC="$TMP_PATH/$(basename $RISC).raw"
  RAW_PREC="$TMP_PATH/$(basename $PREC).raw"
  RAW_TEMP="$TMP_PATH/$(basename $TEMP).raw"
  RAW_UMID="$TMP_PATH/$(basename $UMID).raw"

  OUT_FILE="${BASE_PATH}/scidb/${DATE}.scidb"

  # convertendo para raw
  $TIFF2RAW $RISC $RAW_RISC /dev/null
  $TIFF2RAW $PREC $RAW_PREC /dev/null
  $TIFF2RAW $TEMP $RAW_TEMP /dev/null
  $TIFF2RAW $UMID $RAW_UMID /dev/null

  # junta arquivos
  $INTERLEAVER $OUT_FILE $RAW_RISC 4 $RAW_PREC 4 $RAW_TEMP 4 $RAW_UMID 4

  # apaga arquivos brutos
  rm $RAW_RISC $RAW_PREC $RAW_TEMP $RAW_UMID
done

#date -d "2016-01-02 + 2 days" +"%m-%d-%Y"
