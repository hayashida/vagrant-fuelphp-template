#
# Cookbook Name:: fuelphp
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

template "/etc/httpd/conf.d/fuelphp.conf" do
	source "web_app.conf.erb"
	mode "0644"
	notifies :restart, "service[httpd]"
end

node[:fuel][:db].each do |name|
	execute "create database ${name}" do
		command "mysql -uroot -e 'create database if not exists #{name}'"
		user "vagrant"
	end
end

directory "/mnt/fuelphp" do
	mode "0755"
	action :create
	not_if { File.exists?("/mnt/fuelphp") }
end

link "/home/vagrant/fuelphp" do
	to "/mnt/fuelphp"
end
