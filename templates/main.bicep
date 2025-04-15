targetScope = 'subscription'

param tenantId string
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
param keyvaultObject object
var logicAppConnectionstrings =[
  {
    name: 'AzureWebJobsStorage'
    value: '@Microsoft.KeyVault(SecretUri=https://${keyvault_resource.outputs.uri}/secrets/StorageConnectionString/)}'
  }
  {
    name: 'WEBSITE_CONTENTAZUREFILECONNECTIONSTRING'
    value: '@Microsoft.KeyVault(SecretUri=https://${keyvault_resource.outputs.uri}/secrets/StorageConnectionString/)}'
  }
  {
    name: 'APPLICATIONINSIGHTS_CONNECTION_STRING'
    value: applicationinsight_resource.outputs.instrumentationKey
  }
]


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
    subnetId: subnet_resource.outputs.id
    location: resource_group.location
    keyvaultName:keyvault_resource.outputs.name
  }
  scope: resource_group
}

@description('Create the key vault for the logic app standard')
module keyvault_resource 'keyvault_template.bicep' = {
  name: keyvaultObject.name
  params:{
    name: keyvaultObject.name
    location: resource_group.location
    tenantId: tenantId
    tags: tags
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
    appsettings:[...logicApp.appSettings,...logicAppConnectionstrings] 
  }
scope: resource_group
}



resource appSettings 'Microsoft.Web/sites/config@2022-03-01' = {
  parent: logicapp_standard.id
  name: 'appsettings'
  properties: {
    'MY_SETTING': 'MyValue'
    'ANOTHER_SETTING': 'AnotherValue'
  }
}
