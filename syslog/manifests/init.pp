class syslog {
  package { "rsyslog":
    ensure => installed,
  }
  file { "/etc/rsyslog.conf":
    source => "puppet:///modules/syslog/rsyslog.conf",
    mode   => 0644,
    owner  => root,
    group  => root,
    ensure => present,
  }
  file { "/etc/logrotate.d/rsyslog":
    source => "puppet:///modules/syslog/logrotate",
    mode   => 0644,
    owner  => root,
    group  => root,
    ensure => present,
  }
}
