param logicappname string 
param appsettings array
resource logicAppStandard2 'Microsoft.Web/sites@2024-04-01' existing = {
  name: logicappname
}
var appSettingsObject = reduce(appsettings, {}, (acc, cur) => union(acc, { '${cur.name}': cur.value }))
resource appSettings 'Microsoft.Web/sites/config@2022-03-01' = {
  parent: logicAppStandard2
  name: 'appsettings'
  properties: appSettingsObject

}
