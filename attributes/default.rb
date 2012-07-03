default[:postfix][:myorigin] = node[:fqdn]
default[:postfix][:relayhost] = ''
default[:postfix][:inet_interfaces] = 'all'
default[:postfix][:root_recipient] = ''
default[:postfix][:message_size_limit] = '10240000'
default[:postfix][:smtpd_sasl_type] = ''
default[:postfix][:smtpd_sasl_path] = ''
default[:postfix][:ssl_certificate] = ''
default[:postfix][:content_filtering] = false

default[:postfix][:mysql_domains][:enabled] = 'false'
default[:postfix][:mysql_domains][:spool] = '/data/spool'
default[:postfix][:mysql_domains][:mysql_user] = 'postfix'
default[:postfix][:mysql_domains][:mysql_hostname] = 'mysql-server'
default[:postfix][:mysql_domains][:mysql_database] = 'postfix'
