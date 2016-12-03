#
# Cookbook Name:: php
# Recipe:: default
#
# Copyright (c) 2016 techlinux, All Rights Reserved.

include_recipe 'php::repos'

package 'php70w' do
  action :install
end

%w(php70w-bcmath
   php70w-devel
   php70w-fpm
   php70w-gd
   php70w-imap
   php70w-intl
   php70w-mbstring
   php70w-mcrypt
   php70w-mysqlnd
   php70w-opcache
   php70w-pdo
   php70w-pear
   php70w-pecl-apcu
   php70w-pecl-imagick
   php70w-pecl-xdebug
   php70w-soap
   php70w-tidy
   php70w-xml
   php70w-xmlrpc).each do |pkg|
  package pkg do
    action :install
  end
end

service 'php-fpm' do
  action [:enable, :start]
end

template '/etc/php.ini' do
  source 'php.ini.erb'
  mode 0644
  variables(
    output_buffering: node['php']['output_buffering'],
    max_execution_time: node['php']['max_execution_time'],
    max_input_time: node['php']['max_input_time'],
    memory_limit: node['php']['memory_limit'],
    display_errors: node['php']['display_errors'],
    post_max_size: node['php']['post_max_size'],
    upload_max_filesize: node['php']['upload_max_filesize'],
    max_file_uploads: node['php']['max_file_uploads'],
    date_timezone: node['php']['date_timezone']
  )
  notifies :restart, 'service[php-fpm]'
end
