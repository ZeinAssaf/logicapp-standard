param name string = 'logic-sdc-test-project'
param location string
param workspaceAnalyticsId string
param retentionDays int

resource components_logic_sdc_test_project_name_resource 'Microsoft.Insights/components@2020-02-02' = {
  name: name
  location: location
  kind: 'web'
  properties: {
    Application_Type: 'web'
    Flow_Type: 'Redfield'
    Request_Source: 'IbizaWebAppExtensionCreate'
    RetentionInDays: retentionDays
    WorkspaceResourceId: workspaceAnalyticsId
    IngestionMode: 'LogAnalytics'
    publicNetworkAccessForIngestion: 'disabled'
    publicNetworkAccessForQuery: 'disabled'
    DisableLocalAuth: false
  }
}

output instrumentationKey string = components_logic_sdc_test_project_name_resource.properties.InstrumentationKey
