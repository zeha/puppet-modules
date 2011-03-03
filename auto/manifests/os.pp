class auto::os {
  case $lsbdistid {
    "Debian": { include auto::os::debian }
  }
}

class auto::os::debian {
  include apt
}
