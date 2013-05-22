class kvm::vnode {
  include grub
  include acpi
  include lldp

  package { "libvirt-bin":
    ensure => installed,
  }
}
