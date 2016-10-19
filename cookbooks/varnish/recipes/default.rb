#
# Cookbook Name:: varnish
# Recipe:: default
#
# Copyright (c) 2016 techlinux, All Rights Reserved.

remote_file "#{node['varnish']['tmpdir']}/varnish-#{node['varnish']['version']}.el6.rpm" do
  source "https://repo.varnish-cache.org/redhat/varnish-#{node['varnish']['version']}.el6.rpm"
  action :create
end

rpm_package "varnish-#{node['varnish']['version']}.el6.rpm" do
  source "#{node['varnish']['tmpdir']}/varnish-#{node['varnish']['version']}.el6.rpm"
  action :install
  not_if {File.exist?("/etc/yum.repos.d/varnish-'#{node['varnish']['version']}'.repo")}
end

package "varnish"

service "varnish" do
  action [ :enable, :start ]
end

template "#{node['varnish']['confdirec']}/techl.vcl" do
  source "techl.vcl.erb"
  mode "0644"
  variables(
    :host => node['varnish']['host'],
    :port => node['varnish']['port']
  )
  notifies :restart, 'service[varnish]'
end

template "#{node['varnish']['loaddir']}/varnish" do
  source "varnish.erb"
  mode "0644"
  notifies :restart, 'service[varnish]'
end

template "#{node['varnish']['confdirec']}/varnish.params" do
  source "varnish.params.erb"
  mode 0644
  variables(
    :port => node['varnish']['listenport']
  )
  notifies :restart, 'service[varnish]'
end
