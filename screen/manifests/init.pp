class screen {
  package { "screen":
    ensure => installed,
  }
  file { "/etc/screenrc":
    source => "puppet:///modules/screen/screenrc_generic",
    mode   => 0644,
    owner  => root,
    group  => root,
    ensure => present,
  }
}
