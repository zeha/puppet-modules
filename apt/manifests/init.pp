class apt {
  package { "aptitude":
    ensure => installed
  }
  package { "deborphan":
    ensure => installed
  }

  exec { "apt-get update":
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

class apt::unattendedupgrades {
  package { "unattended-upgrades":
    ensure => installed
  }
  file { "/etc/apt/apt.conf.d/50unattended-upgrades":
    ensure => present,
    mode   => 0644,
    source => "puppet:///modules/apt/50unattended-upgrades.${lsbdistcodename}"
  }
}
