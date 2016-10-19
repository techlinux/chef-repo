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

template "#{node['nginx']['document_root']}/index.html" do
  source 'index.html.erb'
  mode '0644'
  variables(
    :message => node['motd']['message'],
    :port => node['nginx']['port']
  )
end

template "#{node['nginx']['confdirec']}/nginx.conf}" do
  source 'nginx.conf.erb'
  mode 0644
  notifies :restart, 'service[nginx]'
end

template "#{node['nginx']['confdirec']}/conf.d/default.conf" do
  source 'default.conf.erb'
  mode '0644'
  variables(
    :port => node['nginx']['port']
  )
  notifies :restart, 'service[nginx]'
end
