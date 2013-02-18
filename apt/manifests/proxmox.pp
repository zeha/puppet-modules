class apt::proxmox {
  apt::key { "proxmox":
    source  => "puppet:///modules/apt/proxmox.key",
    keyid   => "9887F95A",
    ensure  => present
  }

  file { "/etc/apt/sources.list.d/proxmox.list":
    ensure  => present,
    mode    => 0644,
    source  => "puppet:///modules/apt/proxmox.list.${lsbdistcodename}",
    require => Apt::Key["proxmox"],
    notify  => Exec["apt-get update"]
  }
}
