param name string = 'pep-testproject-dev'
param vnetName string 
param subnetName string
param storageAccountsExternalid string 
param privateDnsZonesName string

resource PrivateDnsZone 'Microsoft.Network/privateDnsZones@2024-06-01' existing= {
  name: privateDnsZonesName
}

var subnetId= resourceId('Microsoft.Network/virtualNetworks/subnets', vnetName, subnetName)
resource privateEndpoints_mnmmbmnm_name_resource 'Microsoft.Network/privateEndpoints@2024-05-01' = {
  name: name
  location: 'swedencentral'
  properties: {
    privateLinkServiceConnections: [
      {
        name: name
        properties: {
          privateLinkServiceId: storageAccountsExternalid
          groupIds: [
            'file'

          ]
          privateLinkServiceConnectionState: {
            status: 'Approved'
            description: 'Auto-Approved'
            actionsRequired: 'None'
          }
        }
      }
    ]
    manualPrivateLinkServiceConnections: []
    customNetworkInterfaceName: '${name}-nic'
    subnet: {
      id: subnetId
    }
    ipConfigurations: []
    customDnsConfigs: []
  }
}

resource privateEndpoints_mnmmbmnm_name_default 'Microsoft.Network/privateEndpoints/privateDnsZoneGroups@2024-05-01' = {
  parent: privateEndpoints_mnmmbmnm_name_resource
  name: 'pvt'
  properties: {
    privateDnsZoneConfigs: [
      {
        name: privateDnsZonesName
        properties: {
          privateDnsZoneId: PrivateDnsZone.id
        }
      }
    ]
  }
}
