targetScope = 'subscription'

param resourceGroupName string
param tags object
param location string
param logSpaceAnalyticsWorskspaceObject object
param applicationinsightObject object
param vnetObject object
param subnetObject object
param appServicePlanObject object
param storageAccountObject object
param logicApp object



//var vnetIdPrefix = '/subscriptions/${subscription().subscriptionId}/resourceGroups/${resourceGroupName}/providers/Microsoft.Network/virtualNetworks/'

@description('Create the resource group')
resource resource_group 'Microsoft.Resources/resourceGroups@2024-11-01' = {
  name: resourceGroupName
  location: location
  tags: tags
}
@description('Create a log space analytics for the data to be ingested')
module log_analytics_workspace 'log_analytics_workspaces_template.bicep' = {
  name: logSpaceAnalyticsWorskspaceObject.name
  params:{
    name: logSpaceAnalyticsWorskspaceObject.name
    location: resource_group.location
    sku: logSpaceAnalyticsWorskspaceObject.sku
    retentionDays: logSpaceAnalyticsWorskspaceObject.retentionDays
    dailyCapInGb: logSpaceAnalyticsWorskspaceObject.dailyCapInGb
  }
  scope: resource_group
}
@description('Create the application insights')
module applicationinsight_resource 'applicationinsights_template.bicep' = {
  name: applicationinsightObject.name
  params:{
    name: applicationinsightObject.name
    location: resource_group.location
    retentionDays:applicationinsightObject.retentionDays
    workspaceAnalyticsId: log_analytics_workspace.outputs.id
  }
  scope: resource_group
}
@description('Create the windows serviceplan for the logic app standard')
module appserviceplan_resource 'appserviceplan_template.bicep' = {
  name: appServicePlanObject.name
  params:{
    name: appServicePlanObject.name
    location: resource_group.location
    sku: appServicePlanObject.sku
    appServicePlanKind: appServicePlanObject.Kind
  }
  scope: resource_group
}
@description('Create the virtual network for the logic app standard')
module vnet_resource 'vnet_template.bicep' = {
  name: vnetObject.name
  params:{
    vnetName: vnetObject.name
    addressPrefixes: vnetObject.addressPrefixes
  }
  scope: resource_group
}

@description('Create the subnet for the logic app standard')
module subnet_resource 'subnet_template.bicep' = {
  name: subnetObject.name
  params:{
    subnetName: subnetObject.name
    parentVnetName: subnetObject.parentVnetName
    addressPrefix: subnetObject.addressPrefix
  }
  scope: resource_group
}

@description('Create the storage account for the logic app standard')
module storageaccount_resource 'storageaccount_template.bicep' = {
  name: storageAccountObject.name
  params:{
    storageName: storageAccountObject.name
    fileShareName: storageAccountObject.fileShareName
    fileServiceName: storageAccountObject.fileServiceName
    subnetId: subnet_resource.outputs.id
  }
  scope: resource_group
}

@description('Create the logic app standard')
module logicapp_standard 'logicapp-standard_template.bicep' = {
  name: 'logicapp-standard'
  params:{
    name: logicApp.name
    location: location
    aspId: appserviceplan_resource.outputs.id
    subnetId: subnet_resource.outputs.id
  }
scope: resource_group
}
