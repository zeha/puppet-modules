class role::vnode {
  include auto::detect
  include puppet::client
  include resolver
  include screen
  include vim
  include zsh

  include openvz::vnode
}
