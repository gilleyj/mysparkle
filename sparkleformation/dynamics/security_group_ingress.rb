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
SparkleFormation.dynamic(:security_group_ingress) do |_name, _config={}|
  ingress_name = "#{_name}_security_group_ingress"
  resources("#{ingress_name}".to_sym) do
  type 'AWS::EC2::SecurityGroupIngress'
  properties do
    from_port _config[:port]
    to_port _config[:port]
    ip_protocol _config[:ip_protocol]
    group_name _config[:group_name]
    if _config[:cidr_ip] then
      cidr_ip _config[:cidr_ip]
    else
      source_security_group_name _config[:source_group_name]
    end
  end
end

#  parameters do
#    set!("#{ingress_name}_port".to_sym) do
#      type 'Number'
#      description "Port for SGI rule"
#      default _config[:port] || '22'
#    end
#    set!("#{ingress_name}_ip_protocol".to_sym) do
#      type 'String'
#      description "Protocol for SGI rule"
#      default _config[:ip_protocol] || 'tcp'
#    end
#  end

#  resources("#{ingress_name}".to_sym) do
#    type 'AWS::EC2::SecurityGroupIngress'
#    properties do
#      from_port ref!("#{ingress_name}_port".to_sym)
#      to_port ref!("#{ingress_name}_port".to_sym)
#      ip_protocol ref!("#{ingress_name}_ip_protocol".to_sym)
#      group_name _config[:group_name]
#      if _config[:cidr_ip] then
#        cidr_ip _config[:cidr_ip]
#      else
#        source_security_group_name _config[:source_group_name]
#      end
#    end
#  end

  # outputs do
  #  set!("#{ingress_name}_port".to_sym) do
  #    description "Port for SGI rule"
  #    value ref!("#{ingress_name}_port".to_sym)
  #  end
  #  set!("#{ingress_name}_ip_protocol".to_sym) do
  #    description "Protocol for SGI rule"
  #    value ref!("#{ingress_name}_ip_protocol".to_sym)
  #  end
  # end
end