class apt {
  package { "aptitude":
    ensure => installed
  }
  package { "deborphan":
    ensure => installed
  }

  exec { "apt-get update":
    path   => ["/usr/bin", "/usr/sbin", "/bin", "/sbin"],
    refreshonly => true
  }

  file { "/etc/apt/apt.conf":
    ensure => present,
    mode   => 0644,
    source => "puppet:///modules/apt/apt.conf"
  }

  file { "/etc/apt/sources.list":
    ensure => present,
    mode   => 0644,
    source => "puppet:///modules/apt/sources.list.${lsbdistcodename}",
    notify => Exec["apt-get update"]
  }
}

define apt::key($source, $ensure, $keyid) {
  file { "/etc/apt/key-${name}.asc":
    owner   => root,
    group   => root,
    mode    => 0644,
    ensure  => $ensure,
    source  => $source,
    notify  => Exec["apt-key add /etc/apt/key-${name}.asc"],
  }
  exec { "apt-key add /etc/apt/key-${name}.asc":
    require => File["/etc/apt/key-${name}.asc"],
    unless  => "apt-key adv --list-keys $keyid",
    path    => ["/usr/bin", "/usr/sbin", "/bin", "/sbin"],
    notify  => Exec["apt-get update"],
  }
}
