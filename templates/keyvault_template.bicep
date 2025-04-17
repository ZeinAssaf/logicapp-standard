param name string
param location string
param tenantId string
param tags object
param subnetId string
resource azure_key_vault 'Microsoft.KeyVault/vaults@2024-12-01-preview' = {
  name: name
  location: location
  tags: tags
  properties: {
    sku: {
      family: 'A'
      name: 'standard'
    }
    tenantId: tenantId
    accessPolicies:[]
    networkAcls: {
      bypass: 'AzureServices'
      virtualNetworkRules: [
        {
          id: subnetId
          ignoreMissingVnetServiceEndpoint: false      
        }
      ]
    }

    enabledForDeployment: false
    enabledForDiskEncryption: false
    enabledForTemplateDeployment: false
    enableSoftDelete: true
    softDeleteRetentionInDays: 30
    enableRbacAuthorization: true
    provisioningState: 'Succeeded'
    publicNetworkAccess: 'disabled'
    enablePurgeProtection: true
  }
}

output uri string = azure_key_vault.properties.vaultUri
output name string= azure_key_vault.name
output id string = azure_key_vault.id
