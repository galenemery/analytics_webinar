name = node["aws_deploy"]["key_name"]

load_balancer "ubuntu-webapp-elb" do
  driver 'aws'
  load_balancer_options :availability_zones => node["aws_deploy"]["availability_zones"],
	  :listeners => [{
		  :port => 80,
		  :protocol => :http,
		  :instance_port => 80,
		  :instance_protocol => :http
		}]
  machines ["#{name}-web1", "#{name}-web2", "#{name}-web3"]
end
