#!/bin/bash

GET_PIXEL="/home/vconrado/Documents/doutorado/disciplinas/CAP-386/vconrado/cap-386/project/src/scripts/getpixel.sh"
IQUERY_GET_PIXEL="iquery -a -q \"subarray(rpth_2016_01_01_B, 750,290,0,750,290,0);\""

N=2
COLS=1199
ROWS=1399
DAY="2016-01-01"
rpth
for i in $(seq $N); do
  C=$(shuf -i 0-$COLS -n 1)
  R=$(shuf -i 0-$ROWS -n 1)
  echo "($C,$R)"
  D=$($GET_PIXEL $DAY $C $R)
  D_R=$(echo $D | cut -d',' -f1)
  D_P=$(echo $D | cut -d',' -f2)
  D_T=$(echo $D | cut -d',' -f3)
  D_H=$(echo $D | cut -d',' -f4)
  echo "$D_R $D_P $D_T $D_H"
  S=$(iquery -a -q "subarray(rpth_2016_01_01_B, $C,$R,0,$C,$R,0);" | grep "{0,0,0}" | cut -d' ' -f2)
  S_R=$(echo $S | cut -d',' -f1)
  S_P=$(echo $S | cut -d',' -f2)
  S_T=$(echo $S | cut -d',' -f3)
  S_H=$(echo $S | cut -d',' -f4)
  echo "$S_R $S_P $S_T $S_H"

done
