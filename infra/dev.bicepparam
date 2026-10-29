using 'main.bicep'

var name = 'roman'

param planName = 'asp-waypoint-${name}'
param planSku = 'F1'
param appName = 'app-waypoint-${name}'
param linuxFxVersion = 'NODE|24-lts'
