param subnetName string 
param parentVnetName string
param addressPrefix string
param usePrivateEndpoint bool=false

resource vnet_resource 'Microsoft.Network/virtualNetworks@2024-05-01' existing = {
  name: parentVnetName
}

resource subnet_resource 'Microsoft.Network/virtualNetworks/subnets@2024-05-01' = {
  parent: vnet_resource
  name: subnetName
  properties: {
    addressPrefix: addressPrefix
    serviceEndpoints: [
      {
        service: 'Microsoft.Storage'
      }
      {
        service: 'Microsoft.KeyVault'
      }
    ]
    delegations: !usePrivateEndpoint? [ {
      name: 'delegation'
      properties: {
        serviceName: 'Microsoft.Web/serverfarms'
      }
      type: 'Microsoft.Network/virtualNetworks/subnets/delegations'
    }  ]:[]
    privateEndpointNetworkPolicies: usePrivateEndpoint? 'Disabled':'Enabled'
    privateLinkServiceNetworkPolicies: 'Enabled'
  }

}

output id string = subnet_resource.id
