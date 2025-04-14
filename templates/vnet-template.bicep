param virtualNetworks_vnet_sdc_test_project_name string = 'vnet-sdc-test-project'

resource virtualNetworks_vnet_sdc_test_project_name_resource 'Microsoft.Network/virtualNetworks@2024-05-01' = {
  name: virtualNetworks_vnet_sdc_test_project_name
  location: 'swedencentral'
  properties: {
    addressSpace: {
      addressPrefixes: [
        '10.0.0.0/16'
      ]
    }
    privateEndpointVNetPolicies: 'Disabled'
    subnets: [
      {
        name: 'snet-sdc-test-project'
        id: virtualNetworks_vnet_sdc_test_project_name_snet_sdc_test_project.id
        properties: {
          addressPrefix: '10.0.0.0/27'
          serviceEndpoints: [
            {
              service: 'Microsoft.Storage'
              locations: [
                'swedencentral'
                'swedensouth'
              ]
            }
          ]
          delegations: [
            {
              name: 'delegation'
              id: '${virtualNetworks_vnet_sdc_test_project_name_snet_sdc_test_project.id}/delegations/delegation'
              properties: {
                serviceName: 'Microsoft.Web/serverfarms'
              }
              type: 'Microsoft.Network/virtualNetworks/subnets/delegations'
            }
          ]
          privateEndpointNetworkPolicies: 'Disabled'
          privateLinkServiceNetworkPolicies: 'Enabled'
        }
        type: 'Microsoft.Network/virtualNetworks/subnets'
      }
    ]
    virtualNetworkPeerings: []
    enableDdosProtection: false
  }
}

resource virtualNetworks_vnet_sdc_test_project_name_snet_sdc_test_project 'Microsoft.Network/virtualNetworks/subnets@2024-05-01' = {
  name: '${virtualNetworks_vnet_sdc_test_project_name}/snet-sdc-test-project'
  properties: {
    addressPrefix: '10.0.0.0/27'
    serviceEndpoints: [
      {
        service: 'Microsoft.Storage'
        locations: [
          'swedencentral'
          'swedensouth'
        ]
      }
    ]
    delegations: [
      {
        name: 'delegation'
        id: '${virtualNetworks_vnet_sdc_test_project_name_snet_sdc_test_project.id}/delegations/delegation'
        properties: {
          serviceName: 'Microsoft.Web/serverfarms'
        }
        type: 'Microsoft.Network/virtualNetworks/subnets/delegations'
      }
    ]
    privateEndpointNetworkPolicies: 'Disabled'
    privateLinkServiceNetworkPolicies: 'Enabled'
  }
  dependsOn: [
    virtualNetworks_vnet_sdc_test_project_name_resource
  ]
}
