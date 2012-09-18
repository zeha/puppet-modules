class munin::server {
  package { "munin":
    ensure  => installed,
  }

  file { "/etc/munin/apache.conf":
    ensure  => present,
    source  => "puppet:///modules/munin/etc/munin/apache.conf"
  }
  file { "/etc/munin/munin.conf":
    ensure  => present,
    mode    => 0644,
    source  => "puppet:///modules/munin/etc/munin/munin.conf"
  }

  # realize exported configs
  File <<| tag == "munin" |>>

  file { "/etc/munin/munin-conf.d":
    ensure  => directory,
    owner   => 'munin',
    mode    => 0700,
    purge   => true,
    recurse => true
  }
}
