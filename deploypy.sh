#!/bin/bash

echo "Make sure Python 3.7 or 3.6 is install and create virtual env"
#install python virtual: sudo apt-get install python3-venv

python3 -m venv .venv

echo "activate the virtual"

source .venv/bin.activate


echo "Publish az function to functionapp"

resGroup=bfkszfuncs
storage=bfkazfuncstorage
funcName=bfkazfuncpythonapp

func init

func new --name mypyfunc --template "HttpTrigger"

echo "Run az function on local"

func start

echo "login az to az: enter your credential"

#az login -u your email

az group create -n $resGroup -l westus

az storage account create -g $resGroup -n $storage --sku Standard_LRS -l westus

az functionapp create -g $resGroup -s $storage -n $funcName --consumption-plan-location westus --os-type Linux --runtime python

func azure functionapp publish bfkazfuncpythonapp
