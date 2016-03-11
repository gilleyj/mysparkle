SfnRegistry.register(:cookbook_branches) do
  {
    production: 'stable-chef-11.10',
    playground: 'master'
  }
end
SfnRegistry.register(:stack_environment_default) { 'playground' }
