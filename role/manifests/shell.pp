class role::shell {
  include auto::detect
  include puppet::client
  include vim
  include zsh
}
