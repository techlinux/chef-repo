# See http://docs.chef.io/config_rb_knife.html for more information on knife configuration options

current_dir = File.dirname(__FILE__)
log_level                :info
log_location             STDOUT
node_name                "hanjrah"
client_key               "#{current_dir}/hanjrah.pem"
validation_client_name	 "techl-validator"
validation_key		 "{current_dir}/techl-validator.pem"
chef_server_url          "https://api.chef.io/organizations/techl"
cache_type		 'BasicFile'
#cache_options ( :path => "{ENV['HOME']}/.chef/checksums" )
cookbook_path            ["#{current_dir}/../cookbooks"]

cookbook_copyright	 "techlinux"
cookbook_license	 "GPLv2"
cookbook_email		 "aman.hanjrah@gmail.com"
