maintainer       'Trond Arve Nordheim'
maintainer_email 't@binarymarbles.com'
license          'Apache 2.0'
description      'Installs and configures Postfix'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '1.0.0'

supports         'debian'

%w(apt openssl ssl_certificates).each do |dependency_name|
  depends dependency_name
end

recipe           'postfix', 'Installs and configures Postfix.'
recipe           'postfix::admin', 'Installs and configures Postfix Admin.'

attribute 'postfix',
  :display_name => 'Postfix',
  :description => 'Hash of Postfix attributes.',
  :type => 'hash'

attribute 'postfix/myorigin',
  :display_name => 'Origin domain',
  :description => 'The origin domain mail are sent from.',
  :default => 'The node FQDN'

attribute 'postfix/relayhost',
  :display_name => 'Relay host',
  :description => 'The next-hop destination of non-local mail.',
  :default => ''

attribute 'postfix/inet_interfaces',
  :display_name => 'Inet interfaces',
  :description => 'The interfaces Postfix should listen to.',
  :default => 'all'

attribute 'postfix/root_recipient',
  :display_name => 'Root recipient',
  :description => 'The e-mail address that should receive mail sent to the local root user.',
  :default => ''

attribute 'postfix/message_size_limit',
  :display_name => 'Message size limit',
  :description => 'Maximum size of incoming e-mail messages.',
  :default => '10240000'

attribute 'postfix/smtpd_sasl_type',
  :display_name => 'SMTPD SASL-type',
  :description => 'The SASL authentication type to use for the SMTP-daemon.',
  :default => ''

attribute 'postfix/smtpd_sasl_path',
  :display_name => 'SMTPD SASL-path',
  :description => 'The path to the SASL authentication socket to use for the SMTP-daemon.',
  :default => ''

attribute 'postfix/ssl_certificate',
  :display_name => 'SSL certificate',
  :description => 'The name of the SSL certificate to use from the certificates data bag.',
  :default => ''

attribute 'postfix/content_filtering',
  :display_name => 'Content filtering',
  :description => 'Enable content filtering using SpamAssassin and ClamAV. This requires that those two cookbooks are enabled for the node.',
  :default => 'false'
  
attribute 'postfix/mysql_domains',
  :display_name => 'MySQL domains',
  :description => 'Hash of MySQL domain attributes.',
  :type => 'hash'

attribute 'postfix/mysql_domains/enabled',
  :display_name => 'Enable MySQL domains',
  :description => 'Enable looking up domains and users in MySQL',
  :default => 'false'

attribute 'postfix/mysql_domains/spool',
  :display_name => 'Spool directory',
  :description => 'Root directory for virtual mailboxes.',
  :default => '/data/spool'

attribute 'postfix/mysql_domains/mysql_user',
  :display_name => 'MySQL username',
  :description => 'Username for the MySQL user Postfix will use.',
  :default => 'postfix'

attribute 'postfix/mysql_domains/mysql_hostname',
  :display_name => 'MySQL server hostname',
  :description => 'Hostname of the MySQL server Postfix will use.',
  :default => 'mysql-server'

attribute 'postfix/mysql_domains/mysql_database',
  :display_name => 'MySQL database',
  :description => 'Name of the MySQL database Postfix will use.',
  :default => 'postfix'
