# Elastic POC

```
Kubernetes
ElasticSearch
Kibana
Elastic APM
```

## How To

Install Docker
```
sudo apt install apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable"
sudo apt update
sudo apt install docker-ce

sudo systemctl status docker
```

Install Kubernetes
```
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl


curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add
sudo apt-add-repository "deb http://apt.kubernetes.io/ kubernetes-xenial main"
sudo apt-get install kubeadm kubelet kubectl
sudo apt-mark hold kubeadm kubelet kubectl
sudo hostnamectl set-hostname master-node
sudo kubeadm init --pod-network-cidr=10.244.0.0/16



curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
sudo install minikube-linux-amd64 /usr/local/bin/minikube
sudo apt-get install virtualbox

minikube start --network="host"
```

Start the server
```
kubectl create -f elasticsearch.yaml
kubectl create -f kibana.yaml
kubectl create -f apm-server.yaml

kubectl port-forward service/elasticsearch 9200 &
kubectl port-forward service/logstash 28777 &

kubectl get services -o wide
kubectl describe pod elasticsearch
kubectl describe pod kibana
kubectl describe pod apm-server


/etc/nginx/conf.d/elastic.conf

server {
        listen 5601;

        location / {
                proxy_pass http://192.168.49.2:31661;
                proxy_http_version 1.1;
                proxy_set_header Upgrade $http_upgrade;
                proxy_set_header Connection 'upgrade';
                proxy_set_header Host $host;
                proxy_cache_bypass $http_upgrade;
        }
}

server {
        listen 8200;

        location / {
                proxy_pass http://192.168.49.2:31001;
                proxy_http_version 1.1;
                proxy_set_header Upgrade $http_upgrade;
                proxy_set_header Connection 'upgrade';
                proxy_set_header Host $host;
                proxy_cache_bypass $http_upgrade;
        }
}

server {
        listen 28778;

        location / {
                proxy_pass http://localhost:28777;
                proxy_http_version 1.1;
                proxy_set_header Upgrade $http_upgrade;
                proxy_set_header Connection 'upgrade';
                proxy_set_header Host $host;
                proxy_cache_bypass $http_upgrade;
        }
}

server {
        listen 9201;

        location / {
                proxy_pass http://localhost:9200;
                proxy_http_version 1.1;
                proxy_set_header Upgrade $http_upgrade;
                proxy_set_header Connection 'upgrade';
                proxy_set_header Host $host;
                proxy_cache_bypass $http_upgrade;
        }
}
```


```
npm i elastic-apm-node --save

const apm = require('elastic-apm-node');
apm.start({
  serviceName: 'pesquisa-api',
  secretToken: '',
  serverUrl: 'http://192.168.15.15:8200'
});


npm i winston-elasticsearch
```
