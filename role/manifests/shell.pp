class role::shell {
  include auto::os
  include puppet::client
  include vim
  include zsh
}
