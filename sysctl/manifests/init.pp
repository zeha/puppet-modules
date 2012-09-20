class sysctl {
  file { "/etc/sysctl.d/local.conf":
    ensure => present,
    source => "puppet:///modules/sysctl/local.conf",
    mode   => 0600,
    owner  => "root",
    group  => "root",
  }
}
