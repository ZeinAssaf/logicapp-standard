param name string
param location string
param sku string
param retentionDays int
param dailyCapInGb int

resource log_analytics_workspace 'Microsoft.OperationalInsights/workspaces@2023-09-01' = {
  name: name
  location: location
  properties: {
    sku: {
      name: sku
    }
    retentionInDays: retentionDays
    features: {
      enableLogAccessUsingOnlyResourcePermissions: true
    }
    workspaceCapping: {
      dailyQuotaGb: dailyCapInGb
    }
    publicNetworkAccessForIngestion: 'disabled'
    publicNetworkAccessForQuery: 'disabled'
  }
}

output id string = log_analytics_workspace.id
