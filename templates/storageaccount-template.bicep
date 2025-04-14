param storageAccounts_rgnew8e0d_name string = 'rgnew8e0d'
param virtualNetworks_vnet_sdc_test_project_externalid string = '/subscriptions/e540cb7c-7267-4ab3-8aff-86ae71c26a72/resourceGroups/rg-new/providers/Microsoft.Network/virtualNetworks/vnet-sdc-test-project'

resource storageAccounts_rgnew8e0d_name_resource 'Microsoft.Storage/storageAccounts@2024-01-01' = {
  name: storageAccounts_rgnew8e0d_name
  location: 'swedencentral'
  sku: {
    name: 'Standard_LRS'
    tier: 'Standard'
  }
  kind: 'StorageV2'
  properties: {
    defaultToOAuthAuthentication: true
    publicNetworkAccess: 'Enabled'
    allowCrossTenantReplication: false
    minimumTlsVersion: 'TLS1_2'
    allowBlobPublicAccess: false
    allowSharedKeyAccess: true
    networkAcls: {
      bypass: 'AzureServices'
      virtualNetworkRules: [
        {
          id: '${virtualNetworks_vnet_sdc_test_project_externalid}/subnets/snet-sdc-test-project'
          action: 'Allow'
          state: 'Succeeded'
        }
      ]
      ipRules: [
        {
          value: '83.251.126.228'
          action: 'Allow'
        }
      ]
      defaultAction: 'Deny'
    }
    supportsHttpsTrafficOnly: true
    encryption: {
      services: {
        file: {
          keyType: 'Account'
          enabled: true
        }
        blob: {
          keyType: 'Account'
          enabled: true
        }
      }
      keySource: 'Microsoft.Storage'
    }
    accessTier: 'Hot'
  }
}

resource storageAccounts_rgnew8e0d_name_default 'Microsoft.Storage/storageAccounts/blobServices@2024-01-01' = {
  parent: storageAccounts_rgnew8e0d_name_resource
  name: 'default'
  sku: {
    name: 'Standard_LRS'
    tier: 'Standard'
  }
  properties: {
    cors: {
      corsRules: []
    }
    deleteRetentionPolicy: {
      allowPermanentDelete: false
      enabled: false
    }
  }
}

resource Microsoft_Storage_storageAccounts_fileServices_storageAccounts_rgnew8e0d_name_default 'Microsoft.Storage/storageAccounts/fileServices@2024-01-01' = {
  parent: storageAccounts_rgnew8e0d_name_resource
  name: 'default'
  sku: {
    name: 'Standard_LRS'
    tier: 'Standard'
  }
  properties: {
    protocolSettings: {
      smb: {}
    }
    cors: {
      corsRules: []
    }
    shareDeleteRetentionPolicy: {
      enabled: true
      days: 7
    }
  }
}

resource Microsoft_Storage_storageAccounts_queueServices_storageAccounts_rgnew8e0d_name_default 'Microsoft.Storage/storageAccounts/queueServices@2024-01-01' = {
  parent: storageAccounts_rgnew8e0d_name_resource
  name: 'default'
  properties: {
    cors: {
      corsRules: []
    }
  }
}

resource Microsoft_Storage_storageAccounts_tableServices_storageAccounts_rgnew8e0d_name_default 'Microsoft.Storage/storageAccounts/tableServices@2024-01-01' = {
  parent: storageAccounts_rgnew8e0d_name_resource
  name: 'default'
  properties: {
    cors: {
      corsRules: []
    }
  }
}

resource storageAccounts_rgnew8e0d_name_default_azure_webjobs_hosts 'Microsoft.Storage/storageAccounts/blobServices/containers@2024-01-01' = {
  parent: storageAccounts_rgnew8e0d_name_default
  name: 'azure-webjobs-hosts'
  properties: {
    immutableStorageWithVersioning: {
      enabled: false
    }
    defaultEncryptionScope: '$account-encryption-key'
    denyEncryptionScopeOverride: false
    publicAccess: 'None'
  }
  dependsOn: [
    storageAccounts_rgnew8e0d_name_resource
  ]
}

resource storageAccounts_rgnew8e0d_name_default_azure_webjobs_secrets 'Microsoft.Storage/storageAccounts/blobServices/containers@2024-01-01' = {
  parent: storageAccounts_rgnew8e0d_name_default
  name: 'azure-webjobs-secrets'
  properties: {
    immutableStorageWithVersioning: {
      enabled: false
    }
    defaultEncryptionScope: '$account-encryption-key'
    denyEncryptionScopeOverride: false
    publicAccess: 'None'
  }
  dependsOn: [
    storageAccounts_rgnew8e0d_name_resource
  ]
}

resource storageAccounts_rgnew8e0d_name_default_logic_sdc_test_projecta56d 'Microsoft.Storage/storageAccounts/fileServices/shares@2024-01-01' = {
  parent: Microsoft_Storage_storageAccounts_fileServices_storageAccounts_rgnew8e0d_name_default
  name: 'logic-sdc-test-projecta56d'
  properties: {
    accessTier: 'TransactionOptimized'
    shareQuota: 102400
    enabledProtocols: 'SMB'
  }
  dependsOn: [
    storageAccounts_rgnew8e0d_name_resource
  ]
}

resource storageAccounts_rgnew8e0d_name_default_flow7961ac592a2d070jobtriggers00 'Microsoft.Storage/storageAccounts/queueServices/queues@2024-01-01' = {
  parent: Microsoft_Storage_storageAccounts_queueServices_storageAccounts_rgnew8e0d_name_default
  name: 'flow7961ac592a2d070jobtriggers00'
  properties: {
    metadata: {}
  }
  dependsOn: [
    storageAccounts_rgnew8e0d_name_resource
  ]
}

resource storageAccounts_rgnew8e0d_name_default_AzureFunctionsScaleMetrics202504 'Microsoft.Storage/storageAccounts/tableServices/tables@2024-01-01' = {
  parent: Microsoft_Storage_storageAccounts_tableServices_storageAccounts_rgnew8e0d_name_default
  name: 'AzureFunctionsScaleMetrics202504'
  properties: {}
  dependsOn: [
    storageAccounts_rgnew8e0d_name_resource
  ]
}

resource storageAccounts_rgnew8e0d_name_default_flow7961ac592a2d07036b74ee51808c36flows 'Microsoft.Storage/storageAccounts/tableServices/tables@2024-01-01' = {
  parent: Microsoft_Storage_storageAccounts_tableServices_storageAccounts_rgnew8e0d_name_default
  name: 'flow7961ac592a2d07036b74ee51808c36flows'
  properties: {}
  dependsOn: [
    storageAccounts_rgnew8e0d_name_resource
  ]
}

resource storageAccounts_rgnew8e0d_name_default_flow7961ac592a2d07038c2558d3283ef1flows 'Microsoft.Storage/storageAccounts/tableServices/tables@2024-01-01' = {
  parent: Microsoft_Storage_storageAccounts_tableServices_storageAccounts_rgnew8e0d_name_default
  name: 'flow7961ac592a2d07038c2558d3283ef1flows'
  properties: {}
  dependsOn: [
    storageAccounts_rgnew8e0d_name_resource
  ]
}

resource storageAccounts_rgnew8e0d_name_default_flow7961ac592a2d07054bd1b7600d187bflows 'Microsoft.Storage/storageAccounts/tableServices/tables@2024-01-01' = {
  parent: Microsoft_Storage_storageAccounts_tableServices_storageAccounts_rgnew8e0d_name_default
  name: 'flow7961ac592a2d07054bd1b7600d187bflows'
  properties: {}
  dependsOn: [
    storageAccounts_rgnew8e0d_name_resource
  ]
}

resource storageAccounts_rgnew8e0d_name_default_flow7961ac592a2d070970afb7a4846fc1flows 'Microsoft.Storage/storageAccounts/tableServices/tables@2024-01-01' = {
  parent: Microsoft_Storage_storageAccounts_tableServices_storageAccounts_rgnew8e0d_name_default
  name: 'flow7961ac592a2d070970afb7a4846fc1flows'
  properties: {}
  dependsOn: [
    storageAccounts_rgnew8e0d_name_resource
  ]
}

resource storageAccounts_rgnew8e0d_name_default_flow7961ac592a2d070flowaccesskeys 'Microsoft.Storage/storageAccounts/tableServices/tables@2024-01-01' = {
  parent: Microsoft_Storage_storageAccounts_tableServices_storageAccounts_rgnew8e0d_name_default
  name: 'flow7961ac592a2d070flowaccesskeys'
  properties: {}
  dependsOn: [
    storageAccounts_rgnew8e0d_name_resource
  ]
}

resource storageAccounts_rgnew8e0d_name_default_flow7961ac592a2d070flowruntimecontext 'Microsoft.Storage/storageAccounts/tableServices/tables@2024-01-01' = {
  parent: Microsoft_Storage_storageAccounts_tableServices_storageAccounts_rgnew8e0d_name_default
  name: 'flow7961ac592a2d070flowruntimecontext'
  properties: {}
  dependsOn: [
    storageAccounts_rgnew8e0d_name_resource
  ]
}

resource storageAccounts_rgnew8e0d_name_default_flow7961ac592a2d070flows 'Microsoft.Storage/storageAccounts/tableServices/tables@2024-01-01' = {
  parent: Microsoft_Storage_storageAccounts_tableServices_storageAccounts_rgnew8e0d_name_default
  name: 'flow7961ac592a2d070flows'
  properties: {}
  dependsOn: [
    storageAccounts_rgnew8e0d_name_resource
  ]
}

resource storageAccounts_rgnew8e0d_name_default_flow7961ac592a2d070flowsubscriptions 'Microsoft.Storage/storageAccounts/tableServices/tables@2024-01-01' = {
  parent: Microsoft_Storage_storageAccounts_tableServices_storageAccounts_rgnew8e0d_name_default
  name: 'flow7961ac592a2d070flowsubscriptions'
  properties: {}
  dependsOn: [
    storageAccounts_rgnew8e0d_name_resource
  ]
}

resource storageAccounts_rgnew8e0d_name_default_flow7961ac592a2d070flowsubscriptionsummary 'Microsoft.Storage/storageAccounts/tableServices/tables@2024-01-01' = {
  parent: Microsoft_Storage_storageAccounts_tableServices_storageAccounts_rgnew8e0d_name_default
  name: 'flow7961ac592a2d070flowsubscriptionsummary'
  properties: {}
  dependsOn: [
    storageAccounts_rgnew8e0d_name_resource
  ]
}

resource storageAccounts_rgnew8e0d_name_default_flow7961ac592a2d070jobdefinitions 'Microsoft.Storage/storageAccounts/tableServices/tables@2024-01-01' = {
  parent: Microsoft_Storage_storageAccounts_tableServices_storageAccounts_rgnew8e0d_name_default
  name: 'flow7961ac592a2d070jobdefinitions'
  properties: {}
  dependsOn: [
    storageAccounts_rgnew8e0d_name_resource
  ]
}

resource storageAccounts_rgnew8e0d_name_default_flow7961ac592a2d070workeraffinitylistenercertificates 'Microsoft.Storage/storageAccounts/tableServices/tables@2024-01-01' = {
  parent: Microsoft_Storage_storageAccounts_tableServices_storageAccounts_rgnew8e0d_name_default
  name: 'flow7961ac592a2d070workeraffinitylistenercertificates'
  properties: {}
  dependsOn: [
    storageAccounts_rgnew8e0d_name_resource
  ]
}
