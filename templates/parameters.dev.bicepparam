using './main.bicep'

param location =  'swedencentral'
param resourceGroupName =  'rg-sdc-testproject-dev1'

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
    name: 'WS1'
    tier: 'WorkflowStandard'
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
  addressPrefix: '10.0.0.0/26'
}
param subnetObjectKeyvault =  {
  name: 'subnet-sdc-kvtestproject-dev'
  parentVnetName: 'vnet-sdc-testproject-dev'
  addressPrefix: '10.0.0.64/27'
}
param storageAccountObject = {
  name: 'stsdctestprojectdev'
  sku: 'Standard_LRS'
  kind: 'StorageV2'
  accessTier: 'Hot'
  enableHttpsTrafficOnly: true
  minTlsVersion: 'TLS1_2'
  fileShareName: 'fileshare-sdc-testproject-dev'
}
param logicApp =  {
  name: 'logic-sdc-testproject-dev'
  appsettings:[
        {
          name: 'APP_KIND'
          value: 'workflowapp'
        }
        {
          name: 'AzureFunctionsJobHost__extensionBundle__id'
          value: 'Microsoft.Azure.Functions.ExtensionBundle.Workflows'
        }
        {
          name: 'AzureFunctionsJobHost__extensionBundle__version'
          value: '[1.*, 2.0.0)'
        }
        {
          name: 'FUNCTIONS_EXTENSION_VERSION'
          value: '~4'
        }
        {
          name: 'FUNCTIONS_WORKER_RUNTIME'
          value: 'dotnet'
        }
        {
          name: 'WEBSITE_CONTENTSHARE'
          value: 'adasd87e7'
        }
        {
          name: 'WEBSITE_NODE_DEFAULT_VERSION'
          value: '~18'
        }
      ]
}

param keyvaultObject =  {
  name: 'kv-sdc-testproject-dev2'
}

param tenantId =  '71c4f45c-272e-421a-b6cb-c5fb553eb61e'
