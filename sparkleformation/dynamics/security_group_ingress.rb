# Config:
#   :port as number
#   :ip_protocol as string
#   :group_name as string
#   :source_security_group_name as string
#
# Create ingress rules
#  dynamic!(:security_group_ingress, 'http',
#           :port => http_protocol,
#           :ip_protocol => http_port,
#           :group_name => ref!(:app_security_group),
#           :cidr_ip => '0.0.0.0/0'
#  )
#
SparkleFormation.dynamic(:security_group_ingress) do |_name, _config = {}|
  ingress_name = "security_group_ingress_#{_name}"
  resources(ingress_name.to_s.to_sym) do
    type 'AWS::EC2::SecurityGroupIngress'
    properties do
      from_port _config[:port]
      to_port _config[:port]
      ip_protocol _config[:ip_protocol]
      group_id _config[:group_id] if _config[:group_id]
      group_name _config[:group_name] if _config[:group_name]
      cidr_ip _config[:cidr_ip] if _config[:cidr_ip]
      if _config[:source_group_name]
        source_security_group_name _config[:source_group_name]
      end
    end
  end
end
