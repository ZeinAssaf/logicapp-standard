param storageName string = 'rgnew8e0d'
param fileShareName string 
//param subnetId string
param location string
param keyvaultName string

resource storageAccounts_resource 'Microsoft.Storage/storageAccounts@2024-01-01' = {
  name: storageName
  location: location
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
  properties: {
    defaultToOAuthAuthentication: true
    publicNetworkAccess: 'Disabled'
    allowCrossTenantReplication: false
    minimumTlsVersion: 'TLS1_2'
    
    allowBlobPublicAccess: false
    allowSharedKeyAccess: true
    networkAcls: {
      bypass: 'AzureServices'
      // virtualNetworkRules: [
      //   {
      //     id: subnetId
      //     action: 'Allow'
      //     state: 'Succeeded'
      //   }
      // ]
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
  parent: storageAccounts_resource
  name: 'default'
  properties: {
    protocolSettings: {
      smb: {}
    }
    cors: {}
    shareDeleteRetentionPolicy: {
      enabled: true
      days: 7
    }
  }
}

resource fileshare_logicapp_resource 'Microsoft.Storage/storageAccounts/fileServices/shares@2023-05-01' = {
  parent: fileshare_service_resource
  name: fileShareName
  properties: {
    accessTier: 'TransactionOptimized'
    shareQuota: 1
    enabledProtocols: 'SMB'
  }
}


resource keyVault 'Microsoft.KeyVault/vaults@2024-12-01-preview' existing = {
  name: keyvaultName
}

resource secret 'Microsoft.KeyVault/vaults/secrets@2022-07-01' = {
  parent: keyVault
  name: 'StorageConnectionString'
  properties: {
    value: 'DefaultEndpointsProtocol=https;AccountName=${storageAccounts_resource.name};AccountKey=${storageAccounts_resource.listKeys().keys[0].value};EndpointSuffix=${environment().suffixes.storage}'
  }
}

output id string = storageAccounts_resource.id
