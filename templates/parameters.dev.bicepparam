using './main.bicep'

param location =  'sweden central'
param logicApp =  {
  name: 'logic-sdc-testproject-dev'
}

param resourceGroupName =  'rg-sdc-testproject-dev'

param tags =  {
  environment: 'dev'
  project: 'sdc-testproject'
  owner: 'sdc-testproject'
}

param appServicePlanSku= {
    name: 'WS1'
    tier: 'WorkflowStandard'
    size: 'WS1'
    family: 'WS'
    capacity: 1
  }
