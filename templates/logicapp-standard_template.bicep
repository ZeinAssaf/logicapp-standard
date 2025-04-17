param name string 
param aspId string 
param subnetId string 
param location string 
//param appsettings array

resource logicapp_standard_resource 'Microsoft.Web/sites@2024-04-01' = {
  name: name
  location: location
  tags: {
    'hidden-link: /app-insights-resource-id': '/subscriptions/e540cb7c-7267-4ab3-8aff-86ae71c26a72/resourceGroups/rg-new/providers/Microsoft.Insights/components/logic-sdc-test-project'
  }
  kind: 'functionapp,workflowapp'
  identity: {
    type: 'SystemAssigned'
  }
  properties: {
    
    enabled: true
    hostNameSslStates: [
      {
        name: '${name}.azurewebsites.net'
        sslState: 'Disabled'
        hostType: 'Standard'
      }
      {
        name: '${name}.scm.azurewebsites.net'
        sslState: 'Disabled'
        hostType: 'Repository'
      }
    ]
    serverFarmId: aspId
    reserved: false
    isXenon: false
    hyperV: false
    dnsConfiguration: {}
    vnetRouteAllEnabled: true
    vnetImagePullEnabled: false
    vnetContentShareEnabled: true
    siteConfig: {
      numberOfWorkers: 1
      acrUseManagedIdentityCreds: false
      alwaysOn: false
      http20Enabled: false
      functionAppScaleLimit: 0
      minimumElasticInstanceCount: 1
      //appSettings: appsettings
    }
    scmSiteAlsoStopped: false
    clientAffinityEnabled: false
    clientCertEnabled: false
    clientCertMode: 'Required'
    hostNamesDisabled: false
    ipMode: 'IPv4'
    vnetBackupRestoreEnabled: false
    customDomainVerificationId: 'BF76C39B96A8E2FB9501A89B60D9C715EEF35D7359344E8C7743AD8826ED9590'
    containerSize: 1536
    dailyMemoryTimeQuota: 0
    httpsOnly: true
    endToEndEncryptionEnabled: false
    redundancyMode: 'None'
    publicNetworkAccess: 'Disabled'
    storageAccountRequired: false
    virtualNetworkSubnetId: subnetId
    keyVaultReferenceIdentity: 'SystemAssigned'
  }
}

resource policies_ftp 'Microsoft.Web/sites/basicPublishingCredentialsPolicies@2024-04-01' = {
  parent: logicapp_standard_resource
  name: 'ftp'
  properties: {
    allow: false
  }
}

resource policies_scm 'Microsoft.Web/sites/basicPublishingCredentialsPolicies@2024-04-01' = {
  parent: logicapp_standard_resource
  name: 'scm'
  properties: {
    allow: false
  }
}

resource sites_logic_sdc_test_project_name_02a5f68e_b864_4f88_829a_9e81b542f8a5_snet_sdc_test_project 'Microsoft.Web/sites/virtualNetworkConnections@2024-04-01' = {
  parent: logicapp_standard_resource
  name: '02a5f68e-b864-4f88-829a-9e81b542f8a5_snet-sdc-test-project'
  properties: {
    vnetResourceId: subnetId
    isSwift: true
  }
}


resource keyVault 'Microsoft.KeyVault/vaults@2022-07-01' existing = {
  name: 'myKeyVault'
}





output principalId string = logicapp_standard_resource.identity.principalId
output id string = logicapp_standard_resource.id



