# Create ingress rules
#  dynamic!(:security_group_ingress, 'http',
#           :port => http_protocol,
#           :ip_protocol => http_port,
#           :group_name => ref!(:app_security_group),
#           :cidr_ip => '0.0.0.0/0'
#  )
#
SparkleFormation.dynamic(:security_group_ingress) do |name, config = {}|
  ingress_name = "security_group_ingress_#{name}"
  resources(ingress_name.to_s.to_sym) do
    type 'AWS::EC2::SecurityGroupIngress'
    properties do
      from_port config[:port]
      to_port config[:port]
      ip_protocol config[:ip_protocol]
      group_id config[:group_id] if config[:group_id]
      group_name config[:group_name] if config[:group_name]
      cidr_ip config[:cidr_ip] if config[:cidr_ip]
      source_security_group_name config[:source_group_name] if config[:source_group_name]
    end
  end
end
