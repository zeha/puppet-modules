class role::puppet {
  include auto::detect
  include puppet::client
  include vim
  include zsh
}
