
SparkleFormation.dynamic(:opsworks_stack) do |_name, _config={}|
  stack_name = "#{_name}_stack"
  resources("#{stack_name}".to_sym) do
    type 'AWS::OpsWorks::Stack'
    properties do
      name stack_name
      shortname _config[:shortname]
    end
  end
end


# "AWS::OpsWorks::Stack": {
#    "properties": [
#      "AgentVersion",
#      "Attributes",
#      "ChefConfiguration",
#      "ConfigurationManager",
#      "CustomCookbooksSource",
#      "CustomJson",
#      "DefaultAvailabilityZone",
#      "DefaultInstanceProfileArn",
#      "DefaultOs",
#      "DefaultRootDeviceType",
#      "DefaultSshKeyName",
#      "DefaultSubnetId",
#      "HostnameTheme",
#      "Name",
#      "ServiceRoleArn",
#      "UseCustomCookbooks",
#      "UseOpsworksSecurityGroups",
#      "VpcId"
#    ],
