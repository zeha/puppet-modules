class role::hudson-master {
  include auto::os
  include puppet::client
  include vim
  include zsh
}
