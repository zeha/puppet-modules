class nullmailer {
  $adminaddr = ymllookup("rootmail")
  $remote    = ymllookup("smarthost")
  package { "nullmailer":
    ensure  => installed,
  }
  service { "nullmailer":
    ensure  => running,
    require => Package["nullmailer"],
  }
  File {
    ensure  => present,
    mode    => 0644,
    owner   => root,
    group   => root,
    notify  => Service["nullmailer"],
  }
  file { "/etc/mailname":
    content => "${fqdn}\n",
  }
  file { "/etc/nullmailer/adminaddr":
    content => "${adminaddr}\n",
  }
  file { "/etc/nullmailer/remotes":
    content => "${remote}\n",
  }
}
