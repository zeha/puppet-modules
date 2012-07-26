class auto::virtual {
  case $virtual {
    "openvzve": { include auto::virtual::openvzve }
    "kvm": { include auto::virtual::kvm }
  }
}

class auto::virtual::openvzve {
  include openvz::container
}

class auto::virtual::kvm {
  include ntp::client
  include grub
}
