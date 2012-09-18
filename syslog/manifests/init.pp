class syslog {
  package { "rsyslog":
    ensure => installed,
  }
  service { "rsyslog":
    require => Package["rsyslog"]
  }
  file { "/etc/rsyslog.conf":
    source => "puppet:///modules/syslog/rsyslog.conf",
    mode   => 0644,
    owner  => root,
    group  => root,
    ensure => present,
    notify => Service["rsyslog"]
  }
  file { "/etc/logrotate.d/rsyslog":
    source => ["puppet:///modules/syslog/logrotate.${lsbdistcodename}", "puppet:///modules/syslog/logrotate"],
    mode   => 0644,
    owner  => root,
    group  => root,
    ensure => present
  }
  file { "/var/spool/rsyslog":
    mode   => 0755,
    owner  => root,
    group  => root,
    ensure => directory
  }
}
