class apt {
  package { "aptitude":
    ensure => installed,
  }

  file { "/etc/apt/apt.conf":
    source => "puppet:///modules/apt/apt.conf",
    mode   => 0644,
    owner  => root,
    group  => root,
    ensure => present,
  }
}

