default[:postfix][:admin][:enabled] = false
default[:postfix][:admin][:version] = '2.3.5'
default[:postfix][:admin][:checksum] = 'd1993ebb5a6c792efc4dfa297e856073474ffce8'
default[:postfix][:admin][:root_directory] = '/var/postfixadmin'
default[:postfix][:admin][:directory] = "#{node[:postfix][:admin][:root_directory]}/postfixadmin-#{node[:postfix][:admin][:version]}"

default[:postfix][:admin][:url] = "http://downloads.sourceforge.net/project/postfixadmin/postfixadmin/postfixadmin-#{node[:postfix][:admin][:version]}/postfixadmin-#{node[:postfix][:admin][:version]}.tar.gz?r=http%3A%2F%2Fsourceforge.net%2Fprojects%2Fpostfixadmin%2Ffiles%2Fpostfixadmin%2Fpostfixadmin-#{node[:postfix][:admin][:version]}%2F&ts=1331643387&use_mirror=heanet"
