class role::puppet {
  include auto::detect
  include puppet::client
  include resolver
  include vim
  include zsh
}
