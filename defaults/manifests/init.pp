class defaults {
  include sysctl
  package { ["locales","acl","heirloom-mailx"]:
    ensure => installed
  }

  class { '::sudo': }
  sudo::conf { 'namespace':
    content => "%staff ALL=(ALL) NOPASSWD: ALL\n",
  }

  include vim
  include zsh
  include syslog
  include resolver
  include puppet::client
}
