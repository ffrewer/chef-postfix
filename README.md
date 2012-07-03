## DESCRIPTION

Installs and configures Postfix for a node.

## REQUIREMENTS

Only tested on Debian 6.0.

## USAGE

The postfix:default recipe configures Postfix according to the configuration
defined as attributes on the node.

````ruby
override_attributes(
  :postfix => {
    :inet_interfaces => 'all', # optional
    :root_recipient => 'operations@myorg.com', # optional
    :message_size_limit => '1073741824', # 1gb, optional
    :content_filtering => true, # optional
    :mysql_domains => { # optional
      :enabled => true,
      :mysql_user => 'postfix',
      :mysql_database => 'postfix'
    },
  }
)
````
