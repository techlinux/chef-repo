#
# Cookbook Name:: mariadb
# Recipe:: _mysqlconf
#
# Copyright (c) 2016 techlinux, All Rights Reserved.

bash "Generate secure password for MariaDB" do
  not_if { File.exist?('/root/.mariadbpassword') }
  code <<-EOH
          set -e
          mysql_password=$(date +%s | sha256sum | base64 | head -c 31 ; echo)
          mysql -u root -e "UPDATE mysql.user SET Password=PASSWORD('$mysql_password') WHERE User='root'; FLUSH PRIVILEGES;"
          echo $mysql_password > '/root/.mariadbpassword'
          EOH
end

bash "Clear unwanted stuff from mariadb" do
  not_if { File.exist?('/root/mariadbnoscript.txt') }
  code <<-EOH

          mysql -uroot -p$(cat /root/.mariadbpassword) -e 'DELETE FROM mysql.user WHERE User="";'
          mysql -uroot -p$(cat /root/.mariadbpassword) -e 'DROP DATABASE test;'
          mysql -uroot -p$(cat /root/.mariadbpassword) -e 'FLUSH PRIVILEGES;'
          touch /root/mariadbnoscript.txt
          EOH
end
