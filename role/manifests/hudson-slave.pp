class role::hudson-slave {
  include auto::os
  include puppet::client
  include vim
  include zsh
}
