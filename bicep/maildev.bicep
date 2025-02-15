param location string
param dnsNameLabel string

resource maildev 'Microsoft.ContainerInstance/containerGroups@2021-07-01' = {
  name: 'maildev'
  location: location
  properties: {
    containers: [
      {
        name: 'maildev'
        properties: {
          image: 'maildev/maildev'
          command:  [
            '/usr/src/app/bin/maildev'
            '-s'
            '1025'
            '-w'
            '1080'
          ]
          ports: [
            {
              port: 1025
              protocol: 'TCP'
            }
            {
              port: 1080
              protocol: 'TCP'
            }
          ]
          resources: {
            requests: {
              cpu: 1
              memoryInGB: 1
            }
          }
        }
      }
    ]
    osType: 'Linux'
    ipAddress: {
      type: 'Public'
      ports: [
        {
          port: 1025
          protocol: 'TCP'
        }
        {
          port: 1080
          protocol: 'TCP'
        }
      ]
      dnsNameLabel: dnsNameLabel
    }
  }
}

output maildevHost string = maildev.properties.ipAddress.fqdn
