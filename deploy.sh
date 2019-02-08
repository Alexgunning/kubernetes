docker build -t dockeralex23/multi-client:latest -t dockeralex23/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t dockeralex23/multi-server:latest -t dockeralex23/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t dockeralex23/multi-worker:latest -t dockeralex23/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push dockeralex23/multi-client:latest
docker push dockeralex23/multi-server:latest
docker push dockeralex23/multi-worker:latest

docker push dockeralex23/multi-client:$SHA
docker push dockeralex23/multi-server:$SHA
docker push dockeralex23/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=dockeralex23/multi-server:$SHA
kubectl set image deployments/client-deployment client=dockeralex23/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=dockeralex23/multi-worker:$SHA
