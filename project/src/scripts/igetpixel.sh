#/bin/bash


if [[ $# -lt 3 ]]; then
  echo "Usage: $(basename $0) YYYY-MM-DD X Y"
  exit 1
fi

DAY=$(date -d "$1" +%j)
DAY_IDX=$(echo "$DAY - 1" | bc)
echo "$1 $DAY $DAY_IDX"
C=$2
R=$3

S=$(iquery -a -q "subarray(rpth, $C,$R,$DAY_IDX,$C,$R,$DAY_IDX);" | grep "{0,0,0}" | cut -d' ' -f2)
S_R=$(echo $S | cut -d',' -f1 | tr -d ' ')
S_P=$(echo $S | cut -d',' -f2 | tr -d ' ')
S_T=$(echo $S | cut -d',' -f3 | tr -d ' ')
S_H=$(echo $S | cut -d',' -f4 | tr -d ' ')


echo "{$C,$R,$DAY_IDX} $S_R, $S_P, $S_T, $S_H"
