class role::hudson-master {
  include auto::detect
  include nullmailer
  include puppet::client
  include resolver
  include screen
  include syslog
  include vim
  include zsh
}
