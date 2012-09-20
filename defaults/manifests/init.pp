class defaults {
  include sysctl
  package { ["locales","acl"]:
    ensure => installed
  }
}
