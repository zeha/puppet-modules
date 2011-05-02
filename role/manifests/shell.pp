class role::shell {
  include auto::detect
  include puppet::client
  include resolver
  include screen
  include vim
  include zsh
}
