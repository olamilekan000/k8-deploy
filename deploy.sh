docker build -t olamilekan000/multi-client:latest -t olamilekan000/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t olamilekan000/multi-server:latest -t olamilekan000/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t olamilekan000/multi-worker -t olamilekan000/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push olamilekan000/multi-client:latest
docker push olamilekan000/multi-server:latest
docker push olamilekan000/multi-worker:latest
docker push olamilekan000/multi-client:$SHA
docker push olamilekan000/multi-server:$SHA
docker push olamilekan000/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=olamilekan000/multi-server:$SHA
kubectl set image deployments/client-deployment client=olamilekan000/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=olamilekan000/multi-worker:$SHA