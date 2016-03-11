
SparkleFormation.dynamic(:opsworks_layer) do |_name, _config = {}|
  layer_name = "#{_name}_layer"
  resources(layer_name.to_s.to_sym) do
    type 'AWS::OpsWorks::Layer'
    properties do
      name "#{_name}_layer"
      shortname _config[:shortname]
      type _config[:type]
      stackid _config[:stackid]
      auto_assign_elastic_ips false
      auto_assign_public_ips true
      enable_auto_healing false

      if _config[:custom_recipes]
        custom_recipes do
          if _config[:custom_recipes_configure]
            configure _config[:custom_recipes_configure]
          end
          setup _config[:custom_recipes_setup] if _config[:custom_recipes_setup]
          if _config[:custom_recipes_deploy]
            deploy _config[:custom_recipes_deploy]
          end
          if _config[:custom_recipes_undeploy]
            undeploy _config[:custom_recipes_undeploy]
          end
        end
      end

      if _config[:custom_security_group_ids]
        custom_security_group_ids _config[:custom_security_group_ids]
      end
    end
  end
end
