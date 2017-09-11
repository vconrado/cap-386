#!/bin/bash
export LC_NUMERIC="en_US.UTF-8"
function test_dif(){
  VAR_NAME=$1
  V1=$2
  V2=$3
  C=$4
  R=$5
  DATE=$6
  DATE_IDX=$7
  V1P=$(printf "%2.4g" $V1)
  V2P=$(printf "%2.4g" $V2)

  if [ $V1P == $V2P  ]; then
    DIF="OK"
  else
    DIF="ERR"
  fi
  printf "($C,$R,$DATE,$DATE_IDX) = $VAR_NAME %2.4g\t%2.4g\t$V1\t$V2 %g $DIF\n" $V1P $V2P
}

LOG_FILE=$(date +%Y%m%d_%S_test_rand.log)
exec >> $LOG_FILE 2>&1

GET_PIXEL="./getpixel.sh"

N=100
COLS=1199
ROWS=1399

START_DATE=$(date -d "2016-02-14 01:00" +%s)
DAYS=322
NEXT=86400 # 86400 is one day
DAY_IDX=0
for ((EPOCH=START_DATE; EPOCH < START_DATE + DAYS*NEXT; EPOCH+=NEXT )); do

    DATE=$(date -d"@$EPOCH" +%Y-%m-%d)
    DAY_IDX=$(date -d"@$EPOCH" +%j)
    DAY_IDX=$(echo "$DAY_IDX - 1" | bc)
    echo "DAY $DATE $DAY_IDX"
	  for i in $(seq $N); do
  	  echo $i
      C=$(shuf -i 0-$COLS -n 1)
      R=$(shuf -i 0-$ROWS -n 1)
      D=$($GET_PIXEL $DATE $C $R)
      D_R=$(echo $D | cut -d',' -f1 | tr -d ' ')
      D_P=$(echo $D | cut -d',' -f2 | tr -d ' ')
      D_T=$(echo $D | cut -d',' -f3 | tr -d ' ')
      D_H=$(echo $D | cut -d',' -f4 | tr -d ' ')
      # echo "$D_R $D_P $D_T $D_H"
      S=$(iquery -a -q "subarray(rpth, $C,$R,$DAY_IDX,$C,$R,$DAY_IDX);" | grep "{0,0,0}" | cut -d' ' -f2)
      S_R=$(echo $S | cut -d',' -f1 | tr -d ' ')
      S_P=$(echo $S | cut -d',' -f2 | tr -d ' ')
      S_T=$(echo $S | cut -d',' -f3 | tr -d ' ')
      S_H=$(echo $S | cut -d',' -f4 | tr -d ' ')
      #  echo "$S_R $S_P $S_T $S_H"
      test_dif "R" $S_R $D_R $C $R $DATE $DAY_IDX
      test_dif "P" $S_P $D_P $C $R $DATE $DAY_IDX
      test_dif "T" $S_T $D_T $C $R $DATE $DAY_IDX
      test_dif "H" $S_H $D_H $C $R $DATE $DAY_IDX
  done
  ((DAY_IDX++))
done
