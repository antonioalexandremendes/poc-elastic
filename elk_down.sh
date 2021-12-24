#!/bin/bash

kubectl delete statefulsets elasticsearch
kubectl delete -f elasticsearch.yaml
kubectl delete -f kibana.yaml
kubectl delete -f logstash.yaml
kubectl delete -f apm-server.yaml

kubectl delete configMap logstash-config
