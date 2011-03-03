class role::vnode {
  include auto::os
  include puppet::client
  include vim
  include zsh

  include openvz::vnode
}
