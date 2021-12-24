#!/bin/bash

kubectl create configmap logstash-config --from-file=logstash.conf

kubectl replace -f elasticsearch.yaml 
kubectl replace -f kibana.yaml
kubectl replace -f logstash.yaml
kubectl replace -f apm-server.yaml
