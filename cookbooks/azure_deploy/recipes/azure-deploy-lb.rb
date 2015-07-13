load_balancer "lupo-web-elb1" do
  load_balancer_options :availability_zones => ['East US'],
		                    :listeners => [{
		                      :port => 80,
		                      :protocol => :http,
		                      :instance_port => 80,
		                      :instance_protocol => :http
		                 }]
  machines ['lupo-web-01','lupo-web-02']
end