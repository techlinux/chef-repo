#
# Cookbook Name:: cron
# Recipe:: chefclient
#
# Copyright (c) 2016 techlinux, All Rights Reserved.

cron 'chef client cron' do
  minute '*/15'
  user 'root'
  command 'chef-client'
#  mailto 'aman.hanjrah@gmail.com'
  action :create
end
