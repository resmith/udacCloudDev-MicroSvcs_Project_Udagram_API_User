#
# Source: https://kubernetes.io/docs/tasks/administer-cluster/dns-debugging-resolution/
# https://kubernetes.io/docs/concepts/services-networking/dns-pod-service/
#
kubectl run -it dnsutils --image gcr.io/kubernetes-e2e-test-images/dnsutils:1.3