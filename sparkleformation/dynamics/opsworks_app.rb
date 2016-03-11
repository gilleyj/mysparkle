#
# create app
#  dynamic!(:opsworks_app, 'app',
#           :type => 'other',
#           :stackid => ref!(:app_stack),
#           :app_source_type => 'git',
#           :app_source_url => 'https://github.com/easybiblabs/opsworks-sample-php',
#           :app_source_branch => 't/moresupervisor'
#  )

SparkleFormation.dynamic(:opsworks_app) do |name, config = {}|
  app_name = name.to_s

  resources(app_name.to_s.to_sym) do
    type 'AWS::OpsWorks::App'
    properties do
      shortname config[:shortname] if config[:shortname]
      type config[:type]
      stackid config[:stackid]
      appsource [
        'Type'      => config[:app_source_type],
        'Url'       => config[:app_source_url],
        'Revision'  => config[:app_source_branch]
      ]
      domains config[:domain] if config[:domain]
    end
  end
end
