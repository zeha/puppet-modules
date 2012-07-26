class grub {
  package { "grub-pc":
    ensure => installed
  }
  file { "/etc/default/grub":
    require => Package["grub-pc"],
    source => "puppet:///modules/grub/grub.default",
    mode => 0644,
    notify => Exec["update-grub"],
  }
  exec { "update-grub":
    path => "/usr/sbin:/sbin:/usr/bin:/bin",
    user => "root",
  }
}
