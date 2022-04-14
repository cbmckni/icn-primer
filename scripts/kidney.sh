#!/bin/bash

NPODS=$1
INDEX=${HOSTNAME##*-}

mkdir -p /workspace/data/kidneydata && cd /workspace/data/kidneydata

printf '/LIBS/GUID = "%s"\n' `uuidgen` > /root/.ncbi/user-settings.mkfg

cat <<EOF > SRA_IDs.txt
SRR5139394
SRR5139395
SRR5139396
SRR5139397
SRR5139398
SRR5139399
SRR5139400
SRR5139401
SRR5139402
SRR5139403
SRR5139404
SRR5139405
SRR5139406
SRR5139407
SRR5139408
SRR5139409
SRR5139410
SRR5139411
SRR5139412
SRR5139413
SRR5139414
SRR5139415
SRR5139416
SRR5139417
SRR5139418
SRR5139419
SRR5139420
SRR5139421
SRR5139422
SRR5139423
SRR5139424
SRR5139425
SRR5139426
SRR5139427
SRR5139428
SRR5139429
EOF

LETTER=$(echo ${INDEX} | tr '[0-9]' '[a-j]')

if [ ${NPODS} -gt 1 ]; then
  split -l $((`wc -l < SRA_IDs.txt`/${NPODS})) SRA_IDs.txt SRA_IDs.txt.split -a 1
  SRAFILE=SRA_IDs.txt.split${LETTER}
else
  SRAFILE=SRA_IDs.txt
fi

while IFS= read -r line
do
  echo ${line} >> times-${INDEX}.txt
  if [ ! -d ${line} ] ; then
    { time prefetch $line ; } 2>> times-${LETTER}.txt
  fi
done < ${SRAFILE}
