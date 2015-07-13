require 'chef/provisioning/azure_driver'
with_driver 'azure'
machine_name = 'galenwintest'

machine "#{machine_name}" do
  machine_options({
    :bootstrap_options => {
      :vm_user => 'localadmin', #required if Windows
      :cloud_service_name => "#{machine_name}", #required
      :storage_account_name => "#{machine_name}", #required, must be letters & numbers ONLY
      :vm_size => 'Standard_D1', #optional
      :location => 'West US', #optional
      :tcp_endpoints => '3389:3389', #optional
      :winrm_transport => { #optional
        'http' => { #required (valid values: 'http', 'https')
          :disable_sspi => false, #optional, (default: false)
          :basic_auth_only => true, #optional, (default: false)
          :no_ssl_peer_verification => true #optional, (default: false)
        }
      }
    },
    :password => 'P2ssw0rd', #required
    :image_id => 'a699494373c04fc0bc8f2bb1389d6106__Windows-Server-2012-R2-201503.01-en.us-127GB.vhd' #required
  })
end