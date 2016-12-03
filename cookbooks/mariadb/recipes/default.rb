#
# Cookbook Name:: mariadb
# Recipe:: default
#
# Copyright (c) 2016 techlinux, All Rights Reserved.

template "#{node['mariadb']['repodir']}/MariaDB.repo" do
  source 'mariadb.repo.erb'
  mode 0644
  variables(
    baseurl: node['mariadb']['baseurl'],
    gpgkey: node['mariadb']['gpgkey']
  )
  not_if { File.exist?("#{node['mariadb']['repodir']}/MariaDB.repo") }
end

bash 'Remove conflicting packages from CentOS 7' do
  code <<-EOF
          rpm --nodeps -e mariadb-libs 2> /dev/null
          exit 0
          EOF
end

%w(MariaDB-server
   MariaDB-client).each do |pkg|
     package pkg do
       action :install
     end
   end

service 'mysql' do
  action [:enable, :start]
end

bash 'Create mysql slow query log file' do
  not_if { File.exist?('/var/log/mysql-slow.log') }
  code <<-EOH
        set -e
        touch /var/log/mysql-slow.log
        chown mysql.mysql /var/log/mysql-slow.log
        chmod 0644 /var/log/mysql-slow.log
    EOH
end

template '/etc/my.cnf' do
  source 'my.cnf.erb'
  mode 0644
  notifies :restart, 'service[mysql]'
end
