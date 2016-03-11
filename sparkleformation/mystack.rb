SparkleFormation.new('sample_app').load(:base).overrides do

  description 'sample web application'

  # Setup reusable values
  http_protocol = 'tcp'
  http_port = '80'

  https_protocol = 'tcp'
  https_protocol = '443'

  # Create the security groups
  dynamic!(:security_group, 'app')

  # Create ingress rules
  dynamic!(:security_group_ingress, 'http',
           :port => http_protocol,
           :ip_protocol => http_port,
           :group_name => ref!(:app_security_group),
           :cidr_ip => '0.0.0.0/0'
  )
  dynamic!(:security_group_ingress, 'https',
           :port => https_protocol,
           :ip_protocol => https_port,
           :group_name => ref!(:app_security_group),
           :cidr_ip => '0.0.0.0/0'
  )

  # create Stack
  dynamic!( :opsworks_stack, 'app',
            :shortname => 'myStack',
   )

  # create layer
  dynamic!( :opsworks_layer, 'nginx_app',
            :shortname => 'nginxphpapp',
            :type => 'custom',
            :stackid => ref!(:app_stack),
            :custom_security_group_ids => [ref!(:app_security_group)],
            :custom_recipes => 'git://github.com/till/easybib-cookbooks.git',
            :custom_recipes_configure => ['stack-test::role-sample'],
            :custom_recipes_deploy => ['stack-test::role-sample'],
            :custom_recipes_undeploy => ['ies::role-undeploy'],
  )

  # create app
  dynamic!(:opsworks_app, 'app',
           :type => 'other',
           :stackid => ref!(:app_stack),
           :app_source_type => 'git',
           :app_source_url => 'https://github.com/easybiblabs/opsworks-sample-php',
           :app_source_branch => 't/moresupervisor'
  )


end