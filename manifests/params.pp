# Class: newrelic::params
#
# This class defines default parameters used by the main module class newrelic
# Operating Systems differences in names and paths are addressed here
#
# == Variables
#
# Refer to newrelic class for the variables defined here.
#
# == Usage
#
# This class is not intended to be used directly.
# It may be imported or inherited by other classes
#
class newrelic::params {

  ### Module specific parameters
  $license_key = 'none'
  $loglevel = 'info'
  $proxy = 'none'
  $ssl_enable = 'false'
  $collector_host = 'collector.newrelic.com'
  $timeout = '30'

  $dependencies_class    = 'newrelic::dependencies'


  ### Application related parameters

  $package = $::operatingsystem ? {
    default => 'newrelic-sysmond',
  }

  $service = $::operatingsystem ? {
    default => 'newrelic-sysmond',
  }

  $service_status = $::operatingsystem ? {
    default => true,
  }

  $process = $::operatingsystem ? {
    default => 'newrelic-sysmond',
  }

  $process_args = $::operatingsystem ? {
    default => '',
  }

  $process_user = $::operatingsystem ? {
    default => 'newrelic',
  }

  $config_dir = $::operatingsystem ? {
    default => '/etc/newrelic',
  }

  $config_file = $::operatingsystem ? {
    default => '/etc/newrelic/nrsysmond.cfg',
  }

  $config_file_mode = $::operatingsystem ? {
    default => '0644',
  }

  $config_file_owner = $::operatingsystem ? {
    default => 'root',
  }

  $config_file_group = $::operatingsystem ? {
    default => 'root',
  }

  $config_file_init = $::operatingsystem ? {
    /(?i:Debian|Ubuntu|Mint)/ => '/etc/default/newrelic-sysmond',
    default                   => '/etc/sysconfig/newrelic-sysmond',
  }

  $pid_file = $::operatingsystem ? {
    default => '/var/run/nrsysmond.pid',
  }

  $data_dir = $::operatingsystem ? {
    default => '/etc/newrelic',
  }

  $log_dir = $::operatingsystem ? {
    default => '/var/log/newrelic',
  }

  $log_file = $::operatingsystem ? {
    default => '/var/log/newrelic/nrsysmond.log',
  }

  $port = ''
  $protocol = ''

  # General Settings
  $my_class = ''
  $source = ''
  $source_dir = ''
  $source_dir_purge = false
  $template = 'newrelic/nrsysmond.cfg.erb'
  $options = ''
  $service_autorestart = true
  $version = 'present'
  $absent = false
  $disable = false
  $disableboot = false

  ### General module variables that can have a site or per module default
  $monitor = false
  $monitor_tool = ''
  $monitor_target = $::ipaddress
  $firewall = false
  $firewall_tool = ''
  $firewall_src = '0.0.0.0/0'
  $firewall_dst = $::ipaddress
  $puppi = false
  $puppi_helper = 'standard'
  $debug = false
  $audit_only = false
  $noops = false

}
