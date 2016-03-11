# Config:
#   :shortname as string
#   :type as string
#   :stackid as string
#   :app_source_type as string
#   :app_source_url as string
#   :app_source_branch as string
#   :domain as string
#
# create app
#  dynamic!(:opsworks_app, 'app',
#           :type => 'other',
#           :stackid => ref!(:app_stack),
#           :app_source_type => 'git',
#           :app_source_url => 'https://github.com/easybiblabs/opsworks-sample-php',
#           :app_source_branch => 't/moresupervisor'
#  )

SparkleFormation.dynamic(:opsworks_app) do |_name, _config = {}|
  app_name = _name.to_s

  resources(app_name.to_s.to_sym) do
    type 'AWS::OpsWorks::App'
    properties do
      shortname _config[:shortname] if _config[:shortname]
      type _config[:type]
      stackid _config[:stackid]
      appsource [
        'Type'      => _config[:app_source_type],
        'Url'       => _config[:app_source_url],
        'Revision'  => _config[:app_source_branch]
      ]
      domains _config[:domain] if _config[:domain]
    end
  end
end
