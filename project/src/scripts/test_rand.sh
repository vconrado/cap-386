#!/bin/bash

GET_PIXEL="./getpixel.sh"

N=2000
COLS=1199
ROWS=1399
DAY="2016-01-01"
for i in $(seq $N); do
  echo $i
  C=$(shuf -i 0-$COLS -n 1)
  R=$(shuf -i 0-$ROWS -n 1)
  #C=290
  #R=750
  #echo "($C,$R)"
  D=$($GET_PIXEL $DAY $C $R)
  D_R=$(echo $D | cut -d',' -f1 | tr -d ' ')
  D_P=$(echo $D | cut -d',' -f2 | tr -d ' ')
  D_T=$(echo $D | cut -d',' -f3 | tr -d ' ')
  D_H=$(echo $D | cut -d',' -f4 | tr -d ' ')
 # echo "$D_R $D_P $D_T $D_H"
  S=$(iquery -a -q "subarray(rpth, $C,$R,0,$C,$R,0);" | grep "{0,0,0}" | cut -d' ' -f2)
  S_R=$(echo $S | cut -d',' -f1 | tr -d ' ')
  S_P=$(echo $S | cut -d',' -f2 | tr -d ' ')
  S_T=$(echo $S | cut -d',' -f3 | tr -d ' ')
  S_H=$(echo $S | cut -d',' -f4 | tr -d ' ')
#  echo "$S_R $S_P $S_T $S_H"
  if [ "${S_R:0:5}" != "${D_R:0:5}" ]; then
	echo  "${S_R:0:5} : ${D_R:0:5}"
  fi

  if [ "${S_P:0:5}" != "${D_P:0:5}" ]; then
	echo "${S_P:0:5} : ${D_P:0:5}"
  fi
  if [ "${S_T:0:5}" != "${D_T:0:5}" ]; then
	echo "${S_T:0:5} : ${D_T:0:5}"
  fi
  if [ "${S_H:0:5}" != "${D_H:0:5}" ]; then
	echo  "${S_H:0:5} : ${D_H:0:5}" 
  fi

done
