# puppet-tftp

Manage tftp server and client via Puppet

## Usage

### Install tftp client

```
    class { 'tftp::client': }
```

### Install tftp server
```
    class { 'tftp::server': }
```


## Additional class parameters

### tftp::client
* ensure: installed, latest or absent, default: installed

### tftp::server
* ensure: present or absent, default present
* autoupgrade: true or false, default: false
* package: string, default: OS specific. Set package name, if platform is not supported.
* config_file: string, default: OS specific. Set config_file, if platform is not supported.
* service_ensure: running or stopped, default: running
* service_name: string, default: OS specific. Set service_name, if platform is not supported. 
* service_enable: true or false, default: true
* service_hasstatus: true or false, default: true
* service_hasrestart: true or false, default: true
