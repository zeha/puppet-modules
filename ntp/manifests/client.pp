class ntp::client {
  package { "ntp":
    ensure => installed
  }
  file { "/etc/ntp.conf":
    require => Package["ntp"],
    source => "puppet:///modules/ntp/ntp.conf.client",
    mode => 0640,
    notify => Service["ntp"],
  }
  service { "ntp":
    enable => true
  }
}
