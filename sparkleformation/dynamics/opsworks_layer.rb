#
#  dynamic!(:opsworks_layer, 'SampleLayer',
#           shortname: 'nginxphpapp',
#           type: 'custom',
#           stackid: ref!(:SampleStack_stack),
#           custom_security_group_ids: [ref!(:sample_security_group)],
#           custom_recipes: 'git://github.com/till/easybib-cookbooks.git',
#           custom_recipes_configure: ['stack-test::role-sample'],
#           custom_recipes_deploy: ['stack-test::role-sample'],
#           custom_recipes_undeploy: ['ies::role-undeploy']
#          )

SparkleFormation.dynamic(:opsworks_layer) do |name, config = {}|
  layer_name = "#{name}_layer"

  resources(layer_name.to_s.to_sym) do
    type 'AWS::OpsWorks::Layer'
    properties do
      name "#{name}_layer"
      shortname config[:shortname]
      type config[:type]
      stackid config[:stackid]

      auto_assign_elastic_ips false
      auto_assign_public_ips true
      enable_auto_healing false

      if config[:custom_recipes]
        custom_recipes do
          configure config[:custom_recipes_configure] if config[:custom_recipes_configure]
          setup config[:custom_recipes_setup] if config[:custom_recipes_setup]
          deploy config[:custom_recipes_deploy] if config[:custom_recipes_deploy]
          undeploy config[:custom_recipes_undeploy] if config[:custom_recipes_undeploy]
        end
      end

      custom_security_group_ids config[:custom_security_group_ids] if config[:custom_security_group_ids]
    end
  end
end
