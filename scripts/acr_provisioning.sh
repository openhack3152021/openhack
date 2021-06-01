#!/usr/bin/env bash

RG=openhack37d5bau5rg

groupId=$(az group show \
  --name ${RG} \
  --query id --output tsv)



az ad sp create-for-rbac \
  --scope $groupId \
  --role Contributor \
  --sdk-auth \
  -n "githubacr"


client_id=$(az ad sp list --display-name githubacr | jq -r ".[].appId")
#
"""
{
  "clientId": "7e929c9b-03a6-4e7e-a04a-0c96900bd5c9",
  "clientSecret": "",
  "subscriptionId": "7940440e-4fae-451f-b63c-00b535f65421",
  "tenantId": "2cede782-c9ed-42af-8c37-bf37b48d0b7b",
  "activeDirectoryEndpointUrl": "https://login.microsoftonline.com",
  "resourceManagerEndpointUrl": "https://management.azure.com/",
  "activeDirectoryGraphResourceId": "https://graph.windows.net/",
  "sqlManagementEndpointUrl": "https://management.core.windows.net:8443/",
  "galleryEndpointUrl": "https://gallery.azure.com/",
  "managementEndpointUrl": "https://management.core.windows.net/"
}
"""


registryId=$(az acr show \
  --name openhack37d5bau5acr \
  --query id --output tsv)


az role assignment create \
  --assignee ${client_id} \
  --scope ${registryId} \
  --role AcrPush