# Class: newrelic::dependencies
#
# This class installs newrelic dependencies
#
# == Variables
#
# Refer to newrelic class for the variables defined here.
#
# == Usage
#
# This class is not intended to be used directly.
# It's automatically included by newrelic if the parameter
# install_dependencies is set to true
# Note: This class may contain resources available on the
# Example42 modules set
#
class newrelic::dependencies {

  case $::operatingsystem {
    redhat,centos,scientific,oraclelinux : {
      require yum::repo::newrelic
    }
    ubuntu,debian : {
      require apt::repo::newrelic
    }
    default: { }
  }

}
