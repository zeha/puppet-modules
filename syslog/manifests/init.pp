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
}
