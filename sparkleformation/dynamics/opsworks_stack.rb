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

SparkleFormation.dynamic(:opsworks_stack) do |name, config = {}|
  stack_name = "#{name}_stack"

  resources(stack_name.to_s.to_sym) do
    type 'AWS::OpsWorks::Stack'
    properties do
      name stack_name
      shortname config[:shortname]
      stack_id config[:stackid]

      auto_assign_elastic_ips false
      auto_assign_public_ips true

      if config[:configuration_manager]
        configuration_manager do
          name config[:configuration_manager_name]
          version config[:configuration_manager_version]
        end
      end

      if config[:use_custom_cookbooks]
        configuration_manager do
          name config[:configuration_manager_name]
          version config[:configuration_manager_version]
        end
      end

      if config[:custom_cookbooks_source]
        custom_cookbooks_source config[:custom_cookbooks_source]
        custom_cookbooks_source do
          type config[:custom_cookbooks_source_type]
          url config[:custom_cookbooks_source_url]
          revision config[:custom_cookbooks_source_revision]
        end
      end
    end
  end
end
