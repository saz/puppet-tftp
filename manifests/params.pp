class tftp::params {
  case $::osfamily {
    'Debian': {
      $client_package_name = 'tftp-hpa'
      $server_package_name = 'tftpd-hpa'
      $server_config_file = '/etc/default/tftpd-hpa'
      $server_config_template = 'tftpd-hpa.debian'
      $tftp_user = 'tftp'
      $tftp_dir = '/srv/tftp'
      $service_name = 'tftpd-hpa'
      $service_hasrestart = true
      $service_hasstatus = true
    }
    default: {
      fail("Unsupported platform: ${::osfamily}")
    }
  }
}
