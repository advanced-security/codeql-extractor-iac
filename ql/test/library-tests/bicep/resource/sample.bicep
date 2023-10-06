resource vnet 'Microsoft.Network/virtualNetworks@2021-02-01' = {
  name: 'vnet'
}

resource existingSubnet 'Microsoft.Network/virtualNetworks/subnets@2021-02-01' = {
  parent: vnet
  name: 'subnet'
}

resource nic 'Microsoft.Network/networkInterfaces@2021-05-01' = {
  name: '${name}-nic-${env}'
  location: location
}

resource linuxVm 'Microsoft.Compute/virtualMachines@2020-06-01' = {
  name: '${name}-linux-${env}'
  location: location

  properties: {
    networkProfile: {
      networkInterfaces: [
        {
          id: nic.id
        }
      ]
    }
  }
}
