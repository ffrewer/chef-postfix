#
# Cookbook Name:: postfix
# Recipe:: default
#
# Copyright 2011-2012, Binary Marbles Trond Arve Nordheim
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

::Chef::Recipe.send(:include, Opscode::OpenSSL::Password)
include_recipe 'apt'
include_recipe 'ssl_certificates'

# Configure Postfix pre-seeding.
execute 'preseed postfix' do
  command "debconf-set-selections #{node[:apt][:preseed_directory]}/postfix.seed"
  action :nothing
end
template "#{node[:apt][:preseed_directory]}/postfix.seed" do
  source 'postfix.seed.erb'
  owner 'root'
  group 'root'
  mode '0600'
  notifies :run, resources(:execute => 'preseed postfix'), :immediately
end

# Install Postfix.
%w(postfix mailutils).each do |package_name|
  package package_name do
    action :install
  end
end

# Configure the Postfix service.
service 'postfix' do
  supports :restart => true, :status => true, :reload => true
  action :nothing
end

# Set up the postmap command to rebuild the virtual map.
execute 'rebuild-aliases' do
  command 'newaliases'
  action :nothing
end

# Install the SSL certificate, if requested.
if node[:postfix][:ssl_certificate] != ''
  ssl_certificate node[:postfix][:ssl_certificate]
end

# Configure Postfix.
template '/etc/postfix/main.cf' do
  source 'main.cf.erb'
  owner 'root'
  group 'root'
  mode '0644'
  notifies :restart, resources(:service => 'postfix')
end
template '/etc/postfix/master.cf' do
  source 'master.cf.erb'
  owner 'root'
  group 'root'
  mode '0644'
  notifies :restart, resources(:service => 'postfix')
end
template '/etc/aliases' do
  source 'aliases.erb'
  owner 'root'
  group 'root'
  mode '0644'
  notifies :run, resources(:execute => 'rebuild-aliases')
  notifies :restart, resources(:service => 'postfix')
end

# Configure the virtual domain configuration, if enabled.
if node[:postfix][:mysql_domains][:enabled] == true || node[:postfix][:mysql_domains][:enabled] == 'true'

  # Install the Postfix-MySQL package.
  package 'postfix-mysql' do
    action :install
  end

  # Generate a password to use for the database user.
  node.set_unless[:postfix][:mysql_domains][:mysql_password] = secure_password

  # Write the MySQL configuration files.
  %w(mysql_virtual_alias_maps mysql_virtual_domains_maps mysql_virtual_mailbox_maps).each do |template_name|
    template "/etc/postfix/#{template_name}.cf" do
      source "#{template_name}.cf.erb"
      owner 'root'
      group 'root'
      mode '0644'
    end
  end

end

# Enable the Postfix service.
service 'postfix' do
  action [:enable, :start]
end
