class role::hudson-master {
  include auto::detect
  include puppet::client
  include vim
  include zsh
}
