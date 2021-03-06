#
# Cookbook Name:: varnish
# Recipe:: default
#
# Copyright (c) 2016 techlinux, All Rights Reserved.

remote_file "#{node['varnish']['tmpdir']}/varnish-#{node['varnish']['version']}.el7.rpm" do
  source "https://repo.varnish-cache.org/redhat/varnish-#{node['varnish']['version']}.el7.rpm"
  action :create
end


execute 'clean-yum-cache' do
  command 'yum clean all'
  action :nothing
end

rpm_package "varnish-#{node['varnish']['version']}.el7.rpm" do
  source "#{node['varnish']['tmpdir']}/varnish-#{node['varnish']['version']}.el7.rpm"
  action :install
  notifies :run, 'execute[clean-yum-cache]', :immediately
  not_if { File.exist?("/etc/yum.repos.d/varnish-'#{node['varnish']['version']}'.repo") }
end

package 'varnish'

service 'varnish' do
  action [:enable, :start]
end

template "#{node['varnish']['confdirec']}/techl.vcl" do
  source 'techl.vcl.erb'
  mode 0644
  variables(
    host: node['varnish']['host'],
    port: node['varnish']['port'],
    allowed1: node['varnish']['allowed1'],
    allowed2: node['varnish']['allowed2'],
    allowed3: node['varnish']['allowed3']
  )
  notifies :restart, 'service[varnish]'
end

template "#{node['varnish']['loaddir']}/varnish" do
  source 'varnish.erb'
  mode 0644
  notifies :restart, 'service[varnish]'
end

template "#{node['varnish']['confdirec']}/varnish.params" do
  source 'varnish.params.erb'
  mode 0644
  variables(
    port: node['varnish']['listenport']
  )
  notifies :restart, 'service[varnish]'
end
