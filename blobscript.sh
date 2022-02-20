#!/bin/bash

az group create --name gal-resource-group --location westus
az storage account create 
  --name newstorage1 
  --resource-group gal-resource-group 
  --location westus 
  --sku Standard_RAGRS 
  --kind StorageV2

az storage account create 
  --name newstorage1 
  --resource-group gal-resource-group 
  --location westus 
  --sku Standard_RAGRS 
  --kind StorageV2

az storage container create 
    --account-name newstorage1
    --name newcontainer
    --auth-mode login

az storage container create 
    --account-name newstorage2
    --name newcontainer
    --auth-mode login

export storage1='newstorage1'
export storage2='newstorage2'

export container_name='newcontainer'

for (( b=1; b<=100; b++ ))
do  
   vi blob$b
   az storage blob upload --account-name $storage1 --container-name $container_name  --name blob$b --file blob$b  --auth-mode login 
   azcopy copy 'https://$storage1.blob.core.windows.net/$container_name/<blob-path><SAS-token>' 'https://$storage2.blob.core.windows.net/container_name/<blob-path>'
   
done