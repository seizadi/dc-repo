# Deployment Configuration Repo
The dc-repo is intended to be the source of truth for the deployment of our 
infrastructure both for development and production. The development environments will
range from minikube, kind or eks clusters.

Eventually for production we will transition to 
[cmdb](https://github.com/seizadi/cmdb)
as the source of truth, until
we can run cmdb as a permenant workload we will use 
[cmdb-config](https://github.com/seizadi/cmdb-config)
o seed cmdb using
this dc-repo.

## Requirements

It is assumed that secrets like the ones listed below are available
on the cluster. There should be no secrets checked into the dc-repo
only application configurations.
- Github User/Password or equivalent token
- Dockerhub User/Password or equivalent access token
- AWS access token or Service Account fine-grain IAM

It is assumed that cluster has ArgoCD deployed and we will build targets
for its pipeline using the dc-repo that will be checked into another mono-repo
that is only managed by a micro-service materializing the dc-repo changes
to this repo.

- Install ArgoCD
***[There is an open issue preventing use of ArgoCD with this pattern](https://github.com/argoproj/argo-cd/pull/6280)***

```bash
kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
```

## Refrences

- [ArgoCD docs here](https://argo-cd.readthedocs.io/en/stable/)
- [ArgoCD PoC](https://github.com/seizadi/argo/tree/master/examples/argocd/lab)
