!#/bin/bash

for i in $(seq 1 $2); do kubectl delete pvc $i; done
