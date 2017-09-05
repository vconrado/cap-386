#/bin/bash


if [[ $# -lt 3 ]]; then
  echo "Usage: $(basename $0) YYYY-MM-DD X Y"
  exit 1
fi

DATE_PARAM=$1
X=$2
Y=$3

CUR_DIR="$(dirname "$0")"
source $CUR_DIR/functions.sh

DATE=$(date -d"$DATE_PARAM" +%Y%m%d)

RISC=$(getFileRisc $DATE)
PREC=$(getFilePrec $DATE)
TEMP=$(getFileTemp $DATE)
UMID=$(getFileUmid $DATE)



R=$(gdallocationinfo $RISC $X $Y | grep Value | cut -d':' -f2)
P=$(gdallocationinfo $PREC $X $Y | grep Value | cut -d':' -f2)
T=$(gdallocationinfo $TEMP $X $Y | grep Value | cut -d':' -f2)
H=$(gdallocationinfo $UMID $X $Y | grep Value | cut -d':' -f2)

echo "$R, $P, $T, $H"
