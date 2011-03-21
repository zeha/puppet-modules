class role::silc {
  include auto::detect
  include nullmailer
  include puppet::client
  include resolver
  include vim
  include zsh
}
