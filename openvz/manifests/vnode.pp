class openvz::vnode {

  include grub

  package { "vzctl":
    ensure => installed,
  }

  
}
