using 'main.bicep'

var name = 'roman'

param planName = 'asp-waypoint-${name}'
param planSku = 'F1'
param appName = 'app-waypoint-${name}'
param linuxFxVersion = 'NODE|24-lts'

param registryName = 'crwaypoint${name}'
param workspaceName = 'log-waypoint-${name}'

param actionGroupName = 'ag-waypoint-${name}'
param alertEmail = readEnvironmentVariable('ALERT_EMAIL')
