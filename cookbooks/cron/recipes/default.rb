#
# Cookbook Name:: cron
# Recipe:: default
#
# Copyright (c) 2016 techlinux, All Rights Reserved.

package 'cronie'

service 'crond' do
  action [:enable, :start]
end

include_recipe "cron::chefclient"
