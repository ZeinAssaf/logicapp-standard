targetScope = 'subscription'

param resourceGroupName string
param tags object
param location string
param logicApp object

resource resource_group 'Microsoft.Resources/resourceGroups@2024-11-01' = {
  name: resourceGroupName
  location: location
  tags: tags
}

module logicapp_standard 'logicapp-standard-template.bicep' = {
  name: 'logicapp-standard'
  params:{
    name: logicApp.name
    location: location
    aspId: ''
    vnetId: ''
  }
scope: resource_group
}
