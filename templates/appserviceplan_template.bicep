param name string 
param location string
param sku object
param appServicePlanKind string

resource appserviceplan 'Microsoft.Web/serverfarms@2024-04-01' = {
  name: name
  location: location
  sku: {
    name: sku.name
    tier:  sku.tier
  }
  kind: appServicePlanKind
  properties: {
    perSiteScaling: false
    elasticScaleEnabled: true
    maximumElasticWorkerCount: 20
    isSpot: false
    reserved: false
    isXenon: false
    hyperV: false
    targetWorkerCount: 0
    targetWorkerSizeId: 0
    zoneRedundant: false
  }
}
output id string = appserviceplan.id
