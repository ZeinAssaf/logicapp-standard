param logicAppId string
param keyvaultName string
param logicappPrincipalId string
resource keyvault 'Microsoft.KeyVault/vaults@2024-12-01-preview' existing = {
  name: keyvaultName
}

resource roleAssignment 'Microsoft.Authorization/roleAssignments@2022-04-01' = {
  name: guid(logicAppId, 'KeyVaultSecretsUser')
  properties: {
    roleDefinitionId: subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '4633458b-17de-408a-b874-0445c86b69e6')
    principalId: logicappPrincipalId
    principalType: 'ServicePrincipal'
  }
  scope: keyvault 
}
