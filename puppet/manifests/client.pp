class puppet::client {
  augeas { "puppet-agent-start" :
    context => "/files/etc/default/puppet",
    changes => "set START yes",
  }
  service { "puppet":
    enable => true,
  }
  package { "puppet":
    ensure => installed,
  }
  package { "augeas-lenses":
    ensure => installed,
  }
  package { "libaugeas-ruby1.8":
    ensure => installed,
  }
  package { "lsb-base":
    ensure => installed,
  }
  file { "/etc/puppet/puppet.conf":
    source => "puppet:///modules/puppet/puppet.conf",
    mode   => 0644,
    owner  => root,
    group  => root,
    ensure => present,
    notify => Service["puppet"],
  }
}
