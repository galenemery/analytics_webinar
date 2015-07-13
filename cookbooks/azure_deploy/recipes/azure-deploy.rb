require 'chef/provisioning/azure_driver'
with_driver 'azure'

with_chef_server "https://api.opscode.com/organizations/cloudeval_org",
  :client_name => Chef::Config[:node_name],
  :signing_key_filename => Chef::Config[:client_key]

machine_batch do
  1.upto(2) do |i|
    machine "ubu-lupodemo#{i}" do
      machine_options({
        :bootstrap_options => {
          :cloud_service_name => "ubu-lupodemo#{i}",
          :storage_account_name => "lupoblob",
          :vm_size => "Small",
          :vm_user => "chef",
          :location => 'East US'
        },
        :image_id => 'b39f27a8b8c64d52b05eac6a62ebad85__Ubuntu-14_04_1-LTS-amd64-server-20140927-en-us-30GB',
        :password => 'ChefitUP!'
      })
      recipe 'apt::default'
    end
    action :converge
  end
end
