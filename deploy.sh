docker build -t cutening/multi-client:latest -t cutening/multi-client:$SHA ./client
docker build -t cutening/multi-server:latest -t cutening/multi-server:$SHA ./server
docker build -t cutening/multi-worker:latest -t cutening/multi-worker:$SHA ./worker
docker push cutening/multi-client:latest
docker push cutening/multi-client:$SHA
docker push cutening/multi-server:latest
docker push cutening/multi-server:$SHA
docker push cutening/multi-worker:latest
docker push cutening/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=cutening/multi-server:$SHA
kubectl set image deployments/client-deployment client=cutening/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=cutening/multi-worker:$SHA