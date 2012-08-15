# Class: tftp::server
#
# This module manages tftpd
#
# Parameters:
#   [*ensure*]
#     Ensure if present or absent.
#     Default: present
#
#   [*tftp_dir*]
#     tftpd directory
#     Default: auto-set, platform specific
#
#   [*autoupgrade*]
#     Upgrade package automatically, if there is a newer version.
#     Default: false
#
#   [*package*]
#     Name of the package.
#     Only set this, if your platform is not supported or you know,
#     what you're doing.
#     Default: auto-set, platform specific
#
#   [*config_file*]
#     Main configuration file.
#     Only set this, if your platform is not supported or you know,
#     what you're doing.
#     Default: auto-set, platform specific
#
#   [*service_ensure*]
#     Ensure if service is running or stopped
#     Default: running
#
#   [*service_name*]
#     Name of tftpd service
#     Only set this, if your platform is not supported or you know,
#     what you're doing.
#     Default: auto-set, platform specific
#
#   [*service_enable*]
#     Start service at boot
#     Default: true
#
#   [*service_hasstatus*]
#     Service has status command
#     Default: true
#
#   [*service_hasrestart*]
#     Service has restart command
#     Default: true
#
# Actions:
#   Installs tftpd package and configures it
#
# Requires:
#   Nothing
#
# Sample Usage:
#   class { 'tftp::server': }
#
#
# [Remember: No empty lines between comments and class definition]
class tftp::server(
  $ensure = 'present',
  $tftp_dir = $tftp::params::tftp_dir,
  $autoupgrade = false,
  $package = $tftp::params::server_package_name,
  $config_file = $tftp::params::server_config_file,
  $service_ensure = 'running',
  $service_name = $tftp::params::service_name,
  $service_enable = true,
  $service_hasstatus = $tftp::params::service_hasstatus,
  $service_hasrestart = $tftp::params::service_hasrestart
) inherits tftp::params {

  case $ensure {
    present: {
      if $autoupgrade == true {
        $package_ensure = 'latest'
      } else {
        $package_ensure = 'installed'
      }

      case $service_ensure {
        'running', 'stopped': {
          $service_ensure_real = $service_ensure
        }
        default: {
          fail('service_ensure parameter must be running or stopped')
        }
      }

      $config_ensure = 'file'
    }
    absent: {
      $package_ensure = 'absent'
      $service_ensure_real = 'absent'
      $config_ensure = 'absent'
    }
    default: {
      fail('ensure parameter must be present or absent')
    }
  }

  package { $package:
    ensure => $package_ensure,
  }

  file { $config_file:
    ensure  => $config_ensure,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template("tftp/${tftp::params::server_config_template}"),
    require => Package[$package],
    notify  => Service[$service_name],
  }

  service { $service_name:
    ensure     => $service_ensure_real,
    enable     => $service_enable,
    hasrestart => $service_hasrestart,
    hasstatus  => $service_hasstatus,
    require    => File[$config_file],
  }
}
