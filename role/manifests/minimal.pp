class role::minimal {
  include auto::detect
  include puppet::client
  include resolver
  include screen
  include syslog
  include vim
  include zsh
}
