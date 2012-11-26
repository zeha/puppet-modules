class defaults {
  include sysctl
  package { ["locales","acl","heirloom-mailx"]:
    ensure => installed
  }
}
