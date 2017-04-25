Apige.configure do |config|
  description = <<EOF
This is my first project.
EOF
  config.date = Time.now
  config.author = "Jerry Tao"
  config.version = 'beta'
  config.meta = { project_name: 'My first project', description: description }
  config.templates = {
    head: 'templates/head.md.erb',
    group: 'templates/group.md.erb',
    resources: 'templates/resources.md.erb',
    api: 'templates/api.md.erb',
  }
end
