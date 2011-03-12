class resolver {
  $nameserver   = ymllookup("nameserver")
  $searchdomain = ymllookup("searchdomain")
  file { "/etc/resolv.conf":
    content => template("resolver/resolv.conf.erb"),
    mode    => 0644,
    owner   => root,
    group   => root,
    ensure  => present,
  }
}
