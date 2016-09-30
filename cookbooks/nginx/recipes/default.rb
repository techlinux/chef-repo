#
# Cookbook Name:: nginx
# Recipe:: default
#
# Copyright 2016, techlinux
#
package 'nginx'

service 'nginx' do
  action [ :enable, :start ]
end

template "#{document_root}/index.html" do
  source 'index.html.erb'
  mode '0644'
  variables(
    :message => node['motd']['message'],
    :port => node['nginx']['port']
  )
end
