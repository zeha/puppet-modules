class role::puppet {
  include auto::os
  include puppet::client
  include vim
  include zsh
}
