param storageName string = 'rgnew8e0d'
param fileShareName string 
param fileServiceName string
param subnetId string
//param virtualNetworks_vnet_sdc_test_project_externalid string = '/subscriptions/e540cb7c-7267-4ab3-8aff-86ae71c26a72/resourceGroups/rg-new/providers/Microsoft.Network/virtualNetworks/vnet-sdc-test-project/subnets/snet-sdc-test-project'

resource storageAccounts_rgnew8e0d_name_resource 'Microsoft.Storage/storageAccounts@2024-01-01' = {
  name: storageName
  location: 'swedencentral'
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
  properties: {
    defaultToOAuthAuthentication: true
    publicNetworkAccess: 'disabled'
    allowCrossTenantReplication: false
    minimumTlsVersion: 'TLS1_2'
    allowBlobPublicAccess: false
    allowSharedKeyAccess: true
    networkAcls: {
      bypass: 'AzureServices'
      virtualNetworkRules: [
        {
          id: subnetId
          action: 'Allow'
          state: 'Succeeded'
        }
      ]
      ipRules: [
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



resource fileshare_service_resource 'Microsoft.Storage/storageAccounts/fileServices@2024-01-01' = {
  parent: storageAccounts_rgnew8e0d_name_resource
  name: fileServiceName
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

resource fileshare_logicapp_resource 'Microsoft.Storage/storageAccounts/fileServices/shares@2024-01-01' = {
  parent: fileshare_service_resource
  name: fileShareName
  properties: {
    accessTier: 'TransactionOptimized'
    shareQuota: 102400
    enabledProtocols: 'SMB'
  }
}
