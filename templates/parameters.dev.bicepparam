using './main.bicep'

param location =  'swedencentral'
param resourceGroupName =  'rg-sdc-testproject-dev'

param tags =  {
  environment: 'dev'
  project: 'sdc-testproject'
  owner: 'sdc-testproject'
}
param logSpaceAnalyticsWorskspaceObject =  {
  name: 'log-sdc-testproject-dev'
  sku: 'PerGB2018'
  retentionDays: 30
  dailyCapInGb:1
}

param applicationinsightObject =  {
  name: 'appi-sdc-testproject-dev'
  applicationType: 'web'
  retentionDays: 30
}

param appServicePlanObject ={ 
  name: 'asp-sdc-testproject-dev'
  sku: {
    name: 'WorkflowStandard'
    tier: 'WS1'
  }
  kind:'functionapp,workflowapp'
}

param vnetObject =  {
  name: 'vnet-sdc-testproject-dev'
  addressPrefixes:['10.0.0.0/16']
}
param subnetObject =  {
  name: 'subnet-sdc-testproject-dev'
  parentVnetName: 'vnet-sdc-testproject-dev'
  addressPrefix: '10.0.0.0/27'
}

param storageAccountObject = {
  name: 'stsdctestprojectdev'
  sku: 'Standard_LRS'
  kind: 'StorageV2'
  accessTier: 'Hot'
  enableHttpsTrafficOnly: true
  minTlsVersion: 'TLS1_2'
  fileShareName: 'fileshare-sdc-testproject-dev'
  fileServiceName: 'fileservice-sdc-testproject-dev'
}



param logicApp =  {
  name: 'logic-sdc-testproject-dev'
}
