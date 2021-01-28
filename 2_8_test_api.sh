. ./0_set_env.sh
#
echo "APP_NAME: $APP_NAME"
export POD_NAME=$(kubectl get pods -o custom-columns=NAME:.metadata.name | grep $APP_NAME)
echo "POD_NAME: $POD_NAME"
#
echo "*** Test API from within the API pod"
echo "* exec $POD_NAME -- curl $BASE_URL:$PORT$API_ENDPOINT"
kubectl exec $POD_NAME -- curl -s $BASE_URL:$PORT$API_ENDPOINT
#
echo "\n\n* exec $POD_NAME -- curl $BASE_URL:$PORT$API_ENDPOINT/"
kubectl exec $POD_NAME -- curl -s $BASE_URL:$PORT$API_ENDPOINT/
#
echo "run DNSutils pod"
kubectl run -it dnsutils --image gcr.io/kubernetes-e2e-test-images/dnsutils:1.3
#
echo "\n\n*** Confirm DNS registration from pod - dnsutils - run exec 1st"
echo "* exec dnsutils -- nslookup $APP_NAME"
kubectl exec dnsutils -- nslookup $APP_NAME
#
# echo "*** Test from another pod - DNS Utils"
# echo "\n\n*** exec $POD_NAME -- curl http://$APP_NAME:$PORT$API_ENDPOINT"
# kubectl exec dnsutils -- curl -s http://$APP_NAME:$PORT$API_ENDPOINT
# #
# echo "\n\n*** exec $POD_NAME -- curl http://$APP_NAME:$PORT$API_ENDPOINT/"
# kubectl exec dnsutils -- curl -s http://$APP_NAME:$PORT$API_ENDPOINT/
# #

