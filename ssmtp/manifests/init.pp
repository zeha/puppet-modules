class nullmailer {
  $authuser  = ymllookup("relay_authuser")
  $authpass  = ymllookup("relay_authpass")
  $smarthost = ymllookup("smarthost")

  package { "ssmtp":
    ensure  => installed,
  }
  file { "/etc/ssmtp/ssmtp.conf":
    content => template("ssmtp/ssmtp.conf.erb"),
    require => Package["ssmtp"],
  }
}
