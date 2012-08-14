# Class: tftp::client
#
# This module manages tftp client
#
# Parameters:
#   [*ensure*]
#     Ensure if installed, latest or absent.
#     Default: installed
#
# Actions:
#   Installs tftp package and configures it
#
# Requires:
#   Nothing
#
# Sample Usage:
#   class { 'tftp::client': }
#
#
# [Remember: No empty lines between comments and class definition]
class tftp::client(
  $ensure = 'installed'
) inherits tftp::params {

  package { $tftp::params::client_package_name:
    ensure => $ensure,
  }
}
