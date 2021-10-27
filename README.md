# ICN Primer

This is a tool for creating a scalable array of PVCs and populating them with data from a variety of sources(any container that can pull data).

ICN-Primer is designed to be used to prepare ICN VMs for publishing massive datasets on a Kubernetes cluster. A scalable number of primer pods of any image will deploy to load data to newly created PVCs. Primer pods are 1:1 with PVCs created.

## Configuration

Edit the file `helm/values.yaml`:

### Deployment Settings
```
Deployment:
  Name: kidney-east        # name describing the data/location of the PVCs
  Image: ncbi/sra-tools    # image used to pull data
  Replicas: 5              # number of PVCs/primer pods to be created
  Arg: "tail -f /dev/null" # Entrypoint argument to either idle or start pulling data into /workspace
```

### Resource Requests
```
Resources:
  Requests:
    CPU: 1
    Memory: 4Gi
  Limits:
    CPU: 1
    Memory: 4Gi
```
### PVC Template Settings
```
PVC:
  StorageClass: rook-cephfs-east # valid storageclass
  Storage: 150Gi # per pod
```

## Deployment

To deploy icn-primer, run `helm install <DEPLOYMENT_NAME> helm/` from the `icn-primer/` directory.

## Deletion

After the PVCs are primed with data, delete the primer pods with `helm uninstall <DEPLOYMENT_NAME>`

PVCs and the data will persist and must be deleted manually with `kubectl delete pvc <PVC>` if needed
