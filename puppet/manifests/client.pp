class puppet::client {
  augeas { "puppet-agent-start" :
    context => "/files/etc/default/puppet",
    changes => "set START yes",
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
}
