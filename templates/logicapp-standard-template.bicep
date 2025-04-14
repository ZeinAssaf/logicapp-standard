param name string 
param aspId string 
param vnetId string 
param location string 

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
    virtualNetworkSubnetId: '${vnetId}/subnets/snet-sdc-test-project'
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

// resource config_resource 'Microsoft.Web/sites/config@2024-04-01' = {
//   parent: logicapp_standard_resource
//   name: 'sds'
//   properties: {
//     numberOfWorkers: 1
//     defaultDocuments: [
//       'Default.htm'
//       'Default.html'
//       'Default.asp'
//       'index.htm'
//       'index.html'
//       'iisstart.htm'
//       'default.aspx'
//       'index.php'
//     ]
//     netFrameworkVersion: 'v6.0'
//     requestTracingEnabled: false
//     remoteDebuggingEnabled: false
//     httpLoggingEnabled: false
//     acrUseManagedIdentityCreds: false
//     logsDirectorySizeLimit: 35
//     detailedErrorLoggingEnabled: false
//     publishingUsername: 'REDACTED'
//     scmType: 'None'
//     use32BitWorkerProcess: false
//     webSocketsEnabled: false
//     alwaysOn: false
//     managedPipelineMode: 'Integrated'
//     virtualApplications: [
//       {
//         virtualPath: '/'
//         physicalPath: 'site\\wwwroot'
//         preloadEnabled: false
//       }
//     ]
//     loadBalancing: 'LeastRequests'
//     experiments: {
//       rampUpRules: []
//     }
//     autoHealEnabled: false
//     vnetName: '02a5f68e-b864-4f88-829a-9e81b542f8a5_snet-sdc-test-project'
//     vnetRouteAllEnabled: true
//     vnetPrivatePortsCount: 2
//     publicNetworkAccess: 'Disabled'
//     cors: {
//       supportCredentials: false
//     }
//     localMySqlEnabled: false
//     managedServiceIdentityId: 16581
//     ipSecurityRestrictions: [
//       {
//         ipAddress: 'Any'
//         action: 'Allow'
//         priority: 2147483647
//         name: 'Allow all'
//         description: 'Allow all access'
//       }
//     ]
//     scmIpSecurityRestrictions: [
//       {
//         ipAddress: 'Any'
//         action: 'Allow'
//         priority: 2147483647
//         name: 'Allow all'
//         description: 'Allow all access'
//       }
//     ]
//     scmIpSecurityRestrictionsUseMain: false
//     http20Enabled: false
//     minTlsVersion: '1.2'
//     scmMinTlsVersion: '1.2'
//     ftpsState: 'FtpsOnly'
//     preWarmedInstanceCount: 1
//     functionAppScaleLimit: 0
//     functionsRuntimeScaleMonitoringEnabled: true
//     minimumElasticInstanceCount: 1
//     azureStorageAccounts: {}
//   }
// }

// resource sites_logic_sdc_test_project_name_sites_logic_sdc_test_project_name_azurewebsites_net 'Microsoft.Web/sites/hostNameBindings@2024-04-01' = {
//   parent: logicapp_standard_resource
//   name: '${name}.azurewebsites.net'
//   properties: {
//     siteName: 'logic-sdc-test-project'
//     hostNameType: 'Verified'
//   }
// }

resource sites_logic_sdc_test_project_name_02a5f68e_b864_4f88_829a_9e81b542f8a5_snet_sdc_test_project 'Microsoft.Web/sites/virtualNetworkConnections@2024-04-01' = {
  parent: logicapp_standard_resource
  name: '02a5f68e-b864-4f88-829a-9e81b542f8a5_snet-sdc-test-project'
  properties: {
    vnetResourceId: '${vnetId}/subnets/snet-sdc-test-project'
    isSwift: true
  }
}
