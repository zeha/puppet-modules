class role::hudson-master {
  include auto::detect
  include nullmailer
  include puppet::client
  include resolver
  include vim
  include zsh
}
