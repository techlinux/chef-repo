#
# Cookbook Name:: nginx
# Recipe:: techlinux
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

service 'nginx' do
end

template '/etc/nginx/nginx.conf' do
  source 'nginx.conf.erb'
  mode 0644
  notifies :reload, 'service[nginx]'
end

template '/etc/nginx/conf.d/blog.conf' do
  source 'blog.conf.erb'
  mode 0644
  variables(
    port: node['nginx']['port'],
    servername: node['nginx']['servername'],
    serverroot: node['nginx']['serverroot']
  )
  notifies :reload, 'service[nginx]'
end
