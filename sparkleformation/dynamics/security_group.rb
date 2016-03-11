# Make a default security group
# dynamic!(:security_group, 'sample')

SparkleFormation.dynamic(:security_group) do |name, _config = {}|
  sg_name = "#{name}_security_group"

  # Create the SecurityGroup resource
  resources(sg_name.to_sym) do
    type 'AWS::EC2::SecurityGroup'
    properties do
      group_description "Default security group for #{name} stack"
    end
  end

  # Create the SSH ingress rule for the security group
  resources('security_group_ingress_ssh'.to_sym) do
    type 'AWS::EC2::SecurityGroupIngress'
    properties do
      from_port 22
      to_port 22
      ip_protocol 'tcp'
      source_security_group_name ref!(sg_name.to_sym)
      group_name ref!(sg_name.to_sym)
      cidr_ip '0.0.0.0/0'
    end
  end
end
