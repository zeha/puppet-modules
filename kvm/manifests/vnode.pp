class kvm::vnode {

  include grub

  package { "libvirt-bin":
    ensure => installed,
  }
  
}
