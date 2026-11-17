@description('Region for the identity.')
param location string

@description('Name of the identity the container app pulls its image with.')
param identityName string

resource pullIdentity 'Microsoft.ManagedIdentity/userAssignedIdentities@2024-11-30' = {
  name: identityName
  location: location
}

output pullIdentityId string = pullIdentity.id
output pullIdentityPrincipalId string = pullIdentity.properties.principalId
