#!/bin/bash


if [ $# -lt 1 ]; then
  echo "Usage: $(basename $0) dir"
  exit 1;
fi

DIR=$1
printf "["
P=0
for FILE in `ls ${DIR}/RF*.nc | sort -V`; do
  if [ $P == "1" ]; then
    printf ",\n"
  fi
  DATE=$(basename $FILE | cut -c 4-11)
  echo -n \"${DATE:0:4}-${DATE:4:2}-${DATE:6:2}\"
  P=1
#find . -name "RF*.nc" -exec  sh -c 'A=$(basename $1 | cut -c 4-11); echo ${A:0:4}-${A:4:2}' - {} \;
done
printf "]"




