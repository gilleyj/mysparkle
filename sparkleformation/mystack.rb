SparkleFormation.new('sample_app').load(:base).overrides do
  parameters do
    stack_env_selected do
      type 'String'
      default registry!(:stack_environment_default)
      allowed_values registry!(:cookbook_branches).keys
    end
  end

  description 'sample web application'

  # Setup reusable values
  http_protocol = 'tcp'
  http_port = '80'

  https_protocol = 'tcp'
  https_port = '443'

  # Create the security groups
  dynamic!(:security_group, 'sample')

  # Create ingress rules
  dynamic!(:security_group_ingress, 'http',
           port: http_port,
           ip_protocol: http_protocol,
           source_group_name: ref!(:sample_security_group.to_sym),
           group_name: ref!(:sample_security_group.to_sym),
           cidr_ip: '0.0.0.0/0'
          )
  dynamic!(:security_group_ingress, 'https',
           port: https_port,
           ip_protocol: https_protocol,
           source_group_name: ref!(:sample_security_group.to_sym),
           group_name: ref!(:sample_security_group.to_sym),
           cidr_ip: '0.0.0.0/0'
          )

  # create Stack
  dynamic!(:opsworks_stack, 'SampleStack',
           default_os: 'Ubuntu 14.04 LTS',
           default_instance_profile_arn: 'arn:aws:iam::717370167197:instance-profile/aws-opsworks-ec2-role',
           service_role_arn: 'arn:aws:iam::717370167197:role/aws-opsworks-service-role',
           use_opsworks_security_groups: false,
           configuration_manager: true,
           configuration_manager_name: 'chef',
           configuration_manager_version: '12',
           use_custom_cookbooks: true,
           custom_cookbooks_source: true,
           custom_cookbooks_source_type: 'git',
           custom_cookbooks_source_url: 'https://github.com/till/easybib-cookbooks',
           custom_cookbooks_source_revision: 'master'
          )

  # create layer
  dynamic!(:opsworks_layer, 'SampleLayer',
           shortname: 'nginxphpapp',
           type: 'custom',
           stackid: ref!(:SampleStack_stack),
           custom_security_group_ids: [ref!(:sample_security_group)],
           custom_recipes: 'git://github.com/till/easybib-cookbooks.git',
           custom_recipes_configure: ['stack-test::role-sample'],
           custom_recipes_deploy: ['stack-test::role-sample'],
           custom_recipes_undeploy: ['ies::role-undeploy']
          )

  # create app
  dynamic!(:opsworks_app, 'SimpleApp',
           type: 'other',
           stackid: ref!(:SampleStack_stack),
           app_source_type: 'git',
           app_source_url: 'https://github.com/easybiblabs/opsworks-sample-php',
           app_source_branch: 't/moresupervisor'
          )
end
