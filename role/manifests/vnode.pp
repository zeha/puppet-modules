class role::vnode {
  include auto::detect
  include puppet::client
  include vim
  include zsh

  include openvz::vnode
}
