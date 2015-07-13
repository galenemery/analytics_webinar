machine_options = {
    :bootstrap_options => {
      # :cloud_service_name => 'chefprovisioning', #required - old
      :cloud_service_name => 'lupo-web-01', #required
      # :storage_account_name => 'chefprovisioning', #required
      :storage_account_name => 'lupoblob', #required
      :vm_size => "Small", #required
      :vm_user => "chef",
      :location => 'East US',#, #required
      :tcp_endpoints => '80:80' #optional
    },
    :image_id => 'b39f27a8b8c64d52b05eac6a62ebad85__Ubuntu-14_04_2_LTS-amd64-server-20150309-en-us-30GB',
    # Until SSH keys are supported (soon)
    :password => "ChefitUP!" #required
}
 
machine 'lupo-web-01' do
  machine_options machine_options
  recipe 'apt'
  recipe 'apache'
end
