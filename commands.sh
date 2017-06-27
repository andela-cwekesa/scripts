K8S:

# Start the cluster
minikube start 

# view the cluster details
kubectl cluster-info

# shows all nodes that can be used to host applications
kubectl get nodes

# creates a new deployment
kubectl run kubernetes-bootcamp --image=docker.io/jocatalin/kubernetes-bootcamp:v1 --port=8080

# list available deployments
kubectl get deployments

# To view app, create a route between terminal and the Kubernetes cluster using a proxy
kubectl proxy

# get name of pod
export POD_NAME=$(kubectl get pods -o go-template --template '{{range .items}}{{.metadata.name}}{{"\n"}}{{end}}')
echo $POD_NAME

# list rsces
kubectl get

# show detailed information about a resource
kubectl describe e.g kubectl describe pods

# print the logs from a container in a pod
kubectl logs $POD_NAME CONTAINERNAME

# execute a command on a container in a pod
kubectl exec

kubectl exec -ti $POD_NAME bash #start bash session in pod's container

# list current services in a cluster
kubectl get services

# expose service
kubectl expose deployment/kubernetes-bootcamp --type="NodePort" --port 8080

# delete service
kubectl delete service -l run=kubernetes-bootcamp

# scale deployment
kubectl scale deployments/kubernetes-bootcamp --replicas=4

# To find out the exposed IP 
kubectl describe services/kubernetes-bootcamp

# update image
kubectl set image deployments/kubernetes-bootcamp kubernetes-bootcamp=jocatalin/kubernetes-bootcamp:v10