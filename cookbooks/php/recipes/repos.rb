#
# Cookbook Name:: php
# Recipe:: repos
#
# Copyright (c) 2016 techlinux, All Rights Reserved.

bash 'Install epel repo' do
  not_if { File.exist?('/etc/yum.repos.d/epel.repo') }
  code <<-EOH
          yum install epel-release -y
          EOH
end

bash 'Install webtatic repo' do
  not_if { File.exist?('/etc/yum.repos.d/webtatic.repo') }
  code <<-EOH
          rpm -Uvh https://mirror.webtatic.com/yum/#{node['php']['elver']}/webtatic-release.rpm
          EOH
end
