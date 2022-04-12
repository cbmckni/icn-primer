#!/bin/bash

NPODS=$1
INDEX=${HOSTNAME##*-}

mkdir -p /workspace/data && cd /workspace/data

printf '/LIBS/GUID = "%s"\n' `uuidgen` > /root/.ncbi/user-settings.mkfg

split -l$((`wc -l < $2`/${NPODS})) $2 ${2}.split -da 1

while IFS= read -r line
do
echo ${line} >> times-${INDEX}.txt
{ time prefetch $line ; } 2>> times-${INDEX}.txt
done < ${2}.split${INDEX}
