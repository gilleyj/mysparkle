#
# dynamic!( :opsworks_stack, 'app',
#            :default_os => 'Ubuntu 14.04 LTS',
#            :default_instance_profile_arn => 'arn:aws:iam::717370167197:instance-profile/aws-opsworks-ec2-role',
#            :service_role_arn => 'arn:aws:iam::717370167197:role/aws-opsworks-service-role',
#            :use_opsworks_security_groups => false,
#            :configuration_manager => true,
#            :configuration_manager_name => 'chef',
#            :configuration_manager_version => '12',
#            :use_custom_cookbooks => true,
#            :custom_cookbooks_source => true,
#            :custom_cookbooks_source_type => 'git',
#            :custom_cookbooks_source_url => 'https://github.com/till/easybib-cookbooks',
#            :custom_cookbooks_source_revision => 'master',
#  )

SparkleFormation.dynamic(:opsworks_stack) do |_name, _config = {}|
  stack_name = "#{_name}_stack"
  resources(stack_name.to_s.to_sym) do
    type 'AWS::OpsWorks::Stack'
    properties do
      name stack_name
      shortname _config[:shortname]
      stack_id _config[:stackid]
      auto_assign_elastic_ips false
      auto_assign_public_ips true
      if _config[:configuration_manager]
        configuration_manager do
          name _config[:configuration_manager_name]
          version _config[:configuration_manager_version]
        end
      end

      if _config[:use_custom_cookbooks]
        configuration_manager do
          name _config[:configuration_manager_name]
          version _config[:configuration_manager_version]
        end
      end

      if _config[:custom_cookbooks_source]
        custom_cookbooks_source _config[:custom_cookbooks_source]
        custom_cookbooks_source do
          type _config[:custom_cookbooks_source_type]
          url _config[:custom_cookbooks_source_url]
          revision _config[:custom_cookbooks_source_revision]
        end
      end
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
