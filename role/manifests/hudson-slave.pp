class role::hudson-slave {
  include auto::detect
  include puppet::client
  include vim
  include zsh
}
