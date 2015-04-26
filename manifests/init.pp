# = Class: newrelic
#
# This is the main newrelic class
#
#
# == Parameters
#
# Module specific parameters
#
# [*license_key*]
# Value  : 40-character hexadecimal string provided by New Relic. This is
#          required in order for the server monitor to start.
# Default: none
#
# [*loglevel*]
# Value  : Level of detail you want in the log file (as defined by the logfile
#          setting below. Valid values are (in increasing levels of verbosity):
#          error        - show errors only
#          warning      - show errors and warnings
#          info         - show minimal additional information messages
#          verbose      - show more detailed information messages
#          debug        - show debug messages
#          verbosedebug - show very detailed debug messages
# Default: info
#
# [*proxy*]
# Value  : The name and optional login credentials of the proxy server to use
#          for all communication with the New Relic collector. In its simplest
#          form this setting is just a hostname[:port] setting. The default
#          port if none is specified is 1080. If your proxy requires a user
#          name, use the syntax user@host[:port]. If it also requires a
#          password use the format user:password@host[:port]. For example:
#            fred:secret@proxy.mydomain.com:8181
# Default: none (use a direct connection)
#
# [*ssl_enable*]
# Value  : Whether or not to use the Secure Sockets Layer (SSL) for all
#          communication with the New Relic collector. Possible values are
#          true/on or false/off. In certain rare cases you may need to modify
#          the SSL certificates settings below.
# Default: false
#
# [*host_name*]
# Value  : A meaningful host name to be displayed in the user interface. On
#          many cloud based nodes the host name is incomprehensible and makes
#          finding a specific host problematic. Using this option will allow
#          you to assign a more meaningful name to a host. You must ensure
#          that all your host names are unique.
# Default: Whatever the system calls the host.
# Note   : Can also be set with the -n command line option.
#
# [*collector_host*]
# Value  : The name of the New Relic collector to connect to. This should only
#          ever be changed on advise from a New Relic support staff member.
#          The format is host[:port]. Using a port number of 0 means the default
#          port, which is 80 (if not using the ssl option - see below) or 443
#          if SSL is enabled. If the port is omitted the default value is used.
# Default: collector.newrelic.com
#
# [*timeout*]
# Value  : How long the monitor should wait to contact the collector host. If
#          the connection cannot be established in this period of time, the
#          monitor will progressively back off in 15-second increments, up to
#          a maximum of 300 seconds. Once the initial connection has been
#          established, this value is reset back to the value specified here
#          (or the default). This then sets the maximum time to wait for
#          a connection to the collector to report data. There is no back-off
#          once the original connection has been made. The value is in seconds.
# Default: 30
#
# [*dependencies_class*]
#   The name of the class that installs dependencies and prerequisite
#   resources needed by this module.
#   Default is $newrelic::dependencies which uses Example42 modules.
#   Set to '' false to not install any dependency (you must provide what's
#   defined in newrelic/manifests/dependencies.pp in some way).
#   Set directy the name of a custom class to manage there the dependencies
#
#
# Standard class parameters
# Define the general class behaviour and customizations
#
# [*my_class*]
#   Name of a custom class to autoload to manage module's customizations
#   If defined, newrelic class will automatically "include $my_class"
#   Can be defined also by the (top scope) variable $newrelic_myclass
#
# [*source*]
#   Sets the content of source parameter for main configuration file
#   If defined, newrelic main config file will have the param: source => $source
#   Can be defined also by the (top scope) variable $newrelic_source
#
# [*source_dir*]
#   If defined, the whole newrelic configuration directory content is retrieved
#   recursively from the specified source
#   (source => $source_dir , recurse => true)
#   Can be defined also by the (top scope) variable $newrelic_source_dir
#
# [*source_dir_purge*]
#   If set to true (default false) the existing configuration directory is
#   mirrored with the content retrieved from source_dir
#   (source => $source_dir , recurse => true , purge => true)
#   Can be defined also by the (top scope) variable $newrelic_source_dir_purge
#
# [*template*]
#   Sets the path to the template to use as content for main configuration file
#   If defined, newrelic main config file has: content => content("$template")
#   Note source and template parameters are mutually exclusive: don't use both
#   Can be defined also by the (top scope) variable $newrelic_template
#
# [*options*]
#   An hash of custom options to be used in templates for arbitrary settings.
#   Can be defined also by the (top scope) variable $newrelic_options
#
# [*service_autorestart*]
#   Automatically restarts the newrelic service when there is a change in
#   configuration files. Default: true, Set to false if you don't want to
#   automatically restart the service.
#
# [*version*]
#   The package version, used in the ensure parameter of package type.
#   Default: present. Can be 'latest' or a specific version number.
#   Note that if the argument absent (see below) is set to true, the
#   package is removed, whatever the value of version parameter.
#
# [*absent*]
#   Set to 'true' to remove package(s) installed by module
#   Can be defined also by the (top scope) variable $newrelic_absent
#
# [*disable*]
#   Set to 'true' to disable service(s) managed by module
#   Can be defined also by the (top scope) variable $newrelic_disable
#
# [*disableboot*]
#   Set to 'true' to disable service(s) at boot, without checks if it's running
#   Use this when the service is managed by a tool like a cluster software
#   Can be defined also by the (top scope) variable $newrelic_disableboot
#
# [*monitor*]
#   Set to 'true' to enable monitoring of the services provided by the module
#   Can be defined also by the (top scope) variables $newrelic_monitor
#   and $monitor
#
# [*monitor_tool*]
#   Define which monitor tools (ad defined in Example42 monitor module)
#   you want to use for newrelic checks
#   Can be defined also by the (top scope) variables $newrelic_monitor_tool
#   and $monitor_tool
#
# [*monitor_target*]
#   The Ip address or hostname to use as a target for monitoring tools.
#   Default is the fact $ipaddress
#   Can be defined also by the (top scope) variables $newrelic_monitor_target
#   and $monitor_target
#
# [*puppi*]
#   Set to 'true' to enable creation of module data files that are used by puppi
#   Can be defined also by the (top scope) variables $newrelic_puppi and $puppi
#
# [*puppi_helper*]
#   Specify the helper to use for puppi commands. The default for this module
#   is specified in params.pp and is generally a good choice.
#   You can customize the output of puppi commands for this module using another
#   puppi helper. Use the define puppi::helper to create a new custom helper
#   Can be defined also by the (top scope) variables $newrelic_puppi_helper
#   and $puppi_helper
#
# [*firewall*]
#   Set to 'true' to enable firewalling of the services provided by the module
#   Can be defined also by the (top scope) variables $newrelic_firewall
#   and $firewall
#
# [*firewall_tool*]
#   Define which firewall tool(s) (ad defined in Example42 firewall module)
#   you want to use to open firewall for newrelic port(s)
#   Can be defined also by the (top scope) variables $newrelic_firewall_tool
#   and $firewall_tool
#
# [*firewall_src*]
#   Define which source ip/net allow for firewalling newrelic. Default: 0.0.0.0/0
#   Can be defined also by the (top scope) variables $newrelic_firewall_src
#   and $firewall_src
#
# [*firewall_dst*]
#   Define which destination ip to use for firewalling. Default: $ipaddress
#   Can be defined also by the (top scope) variables $newrelic_firewall_dst
#   and $firewall_dst
#
# [*debug*]
#   Set to 'true' to enable modules debugging
#   Can be defined also by the (top scope) variables $newrelic_debug and $debug
#
# [*audit_only*]
#   Set to 'true' if you don't intend to override existing configuration files
#   and want to audit the difference between existing files and the ones
#   managed by Puppet.
#   Can be defined also by the (top scope) variables $newrelic_audit_only
#   and $audit_only
#
# [*noops*]
#   Set noop metaparameter to true for all the resources managed by the module.
#   Basically you can run a dryrun for this specific module if you set
#   this to true. Default: undef
#
# Default class params - As defined in newrelic::params.
# Note that these variables are mostly defined and used in the module itself,
# overriding the default values might not affected all the involved components.
# Set and override them only if you know what you're doing.
# Note also that you can't override/set them via top scope variables.
#
# [*package*]
#   The name of newrelic package
#
# [*service*]
#   The name of newrelic service
#
# [*service_status*]
#   If the newrelic service init script supports status argument
#
# [*process*]
#   The name of newrelic process
#
# [*process_args*]
#   The name of newrelic arguments. Used by puppi and monitor.
#   Used only in case the newrelic process name is generic (java, ruby...)
#
# [*process_user*]
#   The name of the user newrelic runs with. Used by puppi and monitor.
#
# [*config_dir*]
#   Main configuration directory. Used by puppi
#
# [*config_file*]
#   Main configuration file path
#
# [*config_file_mode*]
#   Main configuration file path mode
#
# [*config_file_owner*]
#   Main configuration file path owner
#
# [*config_file_group*]
#   Main configuration file path group
#
# [*config_file_init*]
#   Path of configuration file sourced by init script
#
# [*pid_file*]
#   Path of pid file. Used by monitor
#
# [*data_dir*]
#   Path of application data directory. Used by puppi
#
# [*log_dir*]
#   Base logs directory. Used by puppi
#
# [*log_file*]
#   Log file(s). Used by puppi
#
# [*port*]
#   The listening port, if any, of the service.
#   This is used by monitor, firewall and puppi (optional) components
#   Note: This doesn't necessarily affect the service configuration file
#   Can be defined also by the (top scope) variable $newrelic_port
#
# [*protocol*]
#   The protocol used by the the service.
#   This is used by monitor, firewall and puppi (optional) components
#   Can be defined also by the (top scope) variable $newrelic_protocol
#
#
# See README for usage patterns.
#
class newrelic (
  $license_key         = params_lookup( 'license_key' ),
  $loglevel            = params_lookup( 'loglevel' ),
  $proxy               = params_lookup( 'proxy' ),
  $ssl_enable          = params_lookup( 'ssl_enable' ),
  $host_name           = params_lookup( 'host_name' ),
  $collector_host      = params_lookup( 'collector_host' ),
  $timeout             = params_lookup( 'timeout' ),
  $dependencies_class  = params_lookup( 'dependencies_class' ),
  $my_class            = params_lookup( 'my_class' ),
  $source              = params_lookup( 'source' ),
  $source_dir          = params_lookup( 'source_dir' ),
  $source_dir_purge    = params_lookup( 'source_dir_purge' ),
  $template            = params_lookup( 'template' ),
  $service_autorestart = params_lookup( 'service_autorestart' , 'global' ),
  $options             = params_lookup( 'options' ),
  $version             = params_lookup( 'version' ),
  $absent              = params_lookup( 'absent' ),
  $disable             = params_lookup( 'disable' ),
  $disableboot         = params_lookup( 'disableboot' ),
  $monitor             = params_lookup( 'monitor' , 'global' ),
  $monitor_tool        = params_lookup( 'monitor_tool' , 'global' ),
  $monitor_target      = params_lookup( 'monitor_target' , 'global' ),
  $puppi               = params_lookup( 'puppi' , 'global' ),
  $puppi_helper        = params_lookup( 'puppi_helper' , 'global' ),
  $firewall            = params_lookup( 'firewall' , 'global' ),
  $firewall_tool       = params_lookup( 'firewall_tool' , 'global' ),
  $firewall_src        = params_lookup( 'firewall_src' , 'global' ),
  $firewall_dst        = params_lookup( 'firewall_dst' , 'global' ),
  $debug               = params_lookup( 'debug' , 'global' ),
  $audit_only          = params_lookup( 'audit_only' , 'global' ),
  $noops               = params_lookup( 'noops' ),
  $package             = params_lookup( 'package' ),
  $service             = params_lookup( 'service' ),
  $service_status      = params_lookup( 'service_status' ),
  $process             = params_lookup( 'process' ),
  $process_args        = params_lookup( 'process_args' ),
  $process_user        = params_lookup( 'process_user' ),
  $config_dir          = params_lookup( 'config_dir' ),
  $config_file         = params_lookup( 'config_file' ),
  $config_file_mode    = params_lookup( 'config_file_mode' ),
  $config_file_owner   = params_lookup( 'config_file_owner' ),
  $config_file_group   = params_lookup( 'config_file_group' ),
  $config_file_init    = params_lookup( 'config_file_init' ),
  $pid_file            = params_lookup( 'pid_file' ),
  $data_dir            = params_lookup( 'data_dir' ),
  $log_dir             = params_lookup( 'log_dir' ),
  $log_file            = params_lookup( 'log_file' ),
  $port                = params_lookup( 'port' ),
  $protocol            = params_lookup( 'protocol' )
  ) inherits newrelic::params {

  $bool_source_dir_purge=any2bool($source_dir_purge)
  $bool_service_autorestart=any2bool($service_autorestart)
  $bool_absent=any2bool($absent)
  $bool_disable=any2bool($disable)
  $bool_disableboot=any2bool($disableboot)
  $bool_monitor=any2bool($monitor)
  $bool_puppi=any2bool($puppi)
  $bool_firewall=any2bool($firewall)
  $bool_debug=any2bool($debug)
  $bool_audit_only=any2bool($audit_only)

  ### Definition of some variables used in the module
  $manage_package = $newrelic::bool_absent ? {
    true  => 'absent',
    false => $newrelic::version,
  }

  $manage_service_enable = $newrelic::bool_disableboot ? {
    true    => false,
    default => $newrelic::bool_disable ? {
      true    => false,
      default => $newrelic::bool_absent ? {
        true  => false,
        false => true,
      },
    },
  }

  $manage_service_ensure = $newrelic::bool_disable ? {
    true    => 'stopped',
    default =>  $newrelic::bool_absent ? {
      true    => 'stopped',
      default => 'running',
    },
  }

  $manage_service_autorestart = $newrelic::bool_service_autorestart ? {
    true    => Service[newrelic],
    false   => undef,
  }

  $manage_file = $newrelic::bool_absent ? {
    true    => 'absent',
    default => 'present',
  }

  if $newrelic::bool_absent == true
  or $newrelic::bool_disable == true
  or $newrelic::bool_disableboot == true {
    $manage_monitor = false
  } else {
    $manage_monitor = true
  }

  if $newrelic::bool_absent == true
  or $newrelic::bool_disable == true {
    $manage_firewall = false
  } else {
    $manage_firewall = true
  }

  $manage_audit = $newrelic::bool_audit_only ? {
    true  => 'all',
    false => undef,
  }

  $manage_file_replace = $newrelic::bool_audit_only ? {
    true  => false,
    false => true,
  }

  $manage_file_source = $newrelic::source ? {
    ''        => undef,
    default   => $newrelic::source,
  }

  $manage_file_content = $newrelic::template ? {
    ''        => undef,
    default   => template($newrelic::template),
  }

  ### Managed resources
  package { $newrelic::package:
    ensure => $newrelic::manage_package,
    noop   => $newrelic::noops,
  }

  service { 'newrelic':
    ensure    => $newrelic::manage_service_ensure,
    name      => $newrelic::service,
    enable    => $newrelic::manage_service_enable,
    hasstatus => $newrelic::service_status,
    pattern   => $newrelic::process,
    require   => Package[$newrelic::package],
    noop      => $newrelic::noops,
  }

  file { 'newrelic.conf':
    ensure  => $newrelic::manage_file,
    path    => $newrelic::config_file,
    mode    => $newrelic::config_file_mode,
    owner   => $newrelic::config_file_owner,
    group   => $newrelic::config_file_group,
    require => Package[$newrelic::package],
    notify  => $newrelic::manage_service_autorestart,
    source  => $newrelic::manage_file_source,
    content => $newrelic::manage_file_content,
    replace => $newrelic::manage_file_replace,
    audit   => $newrelic::manage_audit,
    noop    => $newrelic::noops,
  }

  # The whole newrelic configuration directory can be recursively overriden
  if $newrelic::source_dir {
    file { 'newrelic.dir':
      ensure  => directory,
      path    => $newrelic::config_dir,
      require => Package[$newrelic::package],
      notify  => $newrelic::manage_service_autorestart,
      source  => $newrelic::source_dir,
      recurse => true,
      purge   => $newrelic::bool_source_dir_purge,
      force   => $newrelic::bool_source_dir_purge,
      replace => $newrelic::manage_file_replace,
      audit   => $newrelic::manage_audit,
      noop    => $newrelic::noops,
    }
  }


  ### Include custom class if $my_class is set
  if $newrelic::my_class {
    include $newrelic::my_class
  }

  ### DEPENDENCIES class
  if $newrelic::dependencies_class != '' {
    require $newrelic::dependencies_class
  }

  ### Provide puppi data, if enabled ( puppi => true )
  if $newrelic::bool_puppi == true {
    $classvars=get_class_args()
    puppi::ze { 'newrelic':
      ensure    => $newrelic::manage_file,
      variables => $classvars,
      helper    => $newrelic::puppi_helper,
      noop      => $newrelic::noops,
    }
  }


  ### Service monitoring, if enabled ( monitor => true )
  if $newrelic::bool_monitor == true {
    if $newrelic::port != '' {
      monitor::port { "newrelic_${newrelic::protocol}_${newrelic::port}":
        protocol => $newrelic::protocol,
        port     => $newrelic::port,
        target   => $newrelic::monitor_target,
        tool     => $newrelic::monitor_tool,
        enable   => $newrelic::manage_monitor,
        noop     => $newrelic::noops,
      }
    }
    if $newrelic::service != '' {
      monitor::process { 'newrelic_process':
        process  => $newrelic::process,
        service  => $newrelic::service,
        pidfile  => $newrelic::pid_file,
        user     => $newrelic::process_user,
        argument => $newrelic::process_args,
        tool     => $newrelic::monitor_tool,
        enable   => $newrelic::manage_monitor,
        noop     => $newrelic::noops,
      }
    }
  }


  ### Firewall management, if enabled ( firewall => true )
  if $newrelic::bool_firewall == true and $newrelic::port != '' {
    firewall { "newrelic_${newrelic::protocol}_${newrelic::port}":
      source      => $newrelic::firewall_src,
      destination => $newrelic::firewall_dst,
      protocol    => $newrelic::protocol,
      port        => $newrelic::port,
      action      => 'allow',
      direction   => 'input',
      tool        => $newrelic::firewall_tool,
      enable      => $newrelic::manage_firewall,
      noop        => $newrelic::noops,
    }
  }


  ### Debugging, if enabled ( debug => true )
  if $newrelic::bool_debug == true {
    file { 'debug_newrelic':
      ensure  => $newrelic::manage_file,
      path    => "${settings::vardir}/debug-newrelic",
      mode    => '0640',
      owner   => 'root',
      group   => 'root',
      content => inline_template('<%= scope.to_hash.reject { |k,v| k.to_s =~ /(uptime.*|path|timestamp|free|.*password.*|.*psk.*|.*key)/ }.to_yaml %>'),
      noop    => $newrelic::noops,
    }
  }

}
