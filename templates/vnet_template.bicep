param vnetName string 
param addressPrefixes array

resource vnet_resource 'Microsoft.Network/virtualNetworks@2024-05-01' = {
  name: vnetName
  location: 'swedencentral'
  properties: {
    addressSpace: {
      addressPrefixes: addressPrefixes
    }
    privateEndpointVNetPolicies: 'Disabled'
    virtualNetworkPeerings: []
    enableDdosProtection: false
  }
}

output id string = vnet_resource.id
