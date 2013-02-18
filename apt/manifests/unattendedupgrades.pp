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
