#Universal machine_options
default["aws_deploy"]["region"] = 'us-west-2'
default["aws_deploy"]["location"] = 'us-west-2a'
default["aws_deploy"]["instance_type"] = 'm1.small'
default["aws_deploy"]["key_name"] = 'galen_sa'

#Ubuntu Specific machine_options
## US-West 1 ami
#default["aws_deploy"]["ubuntu"]["image_id"] = 'ami-56120b13'
## US-West 2 AMI  
default["aws_deploy"]["ubuntu"]["image_id"] = 'ami-875b5db7'
default["aws_deploy"]["ubuntu"]["ssh_username"] = 'ubuntu'

default["aws_deploy"]["centos"]["ssh_username"] = 'centos'

#Windows Specific machine_options
default["aws_deploy"]["windows"]["image_id"] = 'ami-f544a3b1'

#Load Balancer Specific options
default["aws_deploy"]["availability_zones"] = ['us-west-2a']

#default["aws_deploy"]["sg_ids"] = ['sg-dfdf19bb']
default["aws_deploy"]["sg_ids"] = ['sg-9f13d2fb']

#Chef Server machine_options
default["aws_deploy"]["chef_server"]["image_id"] = 'ami-0b42423b'
default["aws_deploy"]["chef_server"]["instance_type"] = 't2.medium'
default["aws_deploy"]["chef_server"]["ssh_username"] = 'ec2-user'