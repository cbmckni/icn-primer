# Declare variables to be passed into your templates.



# Deployment Settings

Deployment:
  Name: ndn-sra-preload
  Image: ncbi/sra-tools
  NodeSelector: 
    Enabled: false
    Arg: "kubernetes.io/hostname: epic001.clemson.edu" 
  Replicas: 1
  Arg: "
    printf '/LIBS/GUID = "%s"\n' `uuidgen` > /root/.ncbi/user-settings.mkfg && \
    export INDEX=${HOSTNAME##*-}
    ID=$(sed "${INDEX}q;d" sraIDs.txt)
    fasterq-dump ${ID}
  "

# EXAMPLE PRODUCER: "
# /workspace/ndn/scripts/boot.sh &&
# /workspace/ndn/scripts/put.sh /k8s/pub/file /workspace/ndn/samples/1GB
# "

# EXAMPLE CONSUMER: "
#    rm -rf /workspace/ndn && mkdir -p /workspace/ndn && \
#    apt-get update -y && apt-get install -y git && \
#    git clone --single-branch --branch statefulset https://github.com/cbmckni/ndn-k8s.git /workspace/ndn && \
#    /workspace/ndn/genomics/scripts/sync.sh ndn-k8s-example && \
#    /workspace/ndn/genomics/scripts/boot.sh && \
#    /workspace/ndn/genomics/scripts/route.sh / ndn-k8s-producer-1gb && \
#    /workspace/ndn/genomics/scripts/cat.sh -n /k8s/1gb -o /workspace/ndn/1GB.test -t /workspace/ndn/1GB.test.time && \
#    /workspace/ndn/genomics/scripts/delay.sh
#  "

# EXAMPLE MANUAL: "
# /workspace/ndn/scripts/boot.sh &&
# /workspace/ndn/scripts/delay.sh
# "




# Resource Requests

Resources:
  Requests:
    CPU: 1
    Memory: 4Gi
  Limits:
    CPU: 1
    Memory: 4Gi



# PVC Template Settings

PVC:
  StorageClass: rook-cephfs
  Storage: 5Gi # per pod

# Ingress control settings
Ingress:
  Enabled: false
  # The subdomain to associate with this service.
  Host: ndnlakev1.nautilus.optiputer.net
  # The class of the ingress controller to use.
  Class: traefik

