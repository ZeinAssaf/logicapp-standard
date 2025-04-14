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
