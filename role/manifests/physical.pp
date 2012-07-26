# base-only managed physical host
class role::physical {
  include auto::detect
  include puppet::client
  include resolver
  include screen
  include syslog
  include vim
  include zsh
}
