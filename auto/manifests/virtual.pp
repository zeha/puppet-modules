class auto::virtual {
  case $virtual {
    "openvzve": { include auto::virtual::openvzve }
  }
}

class auto::virtual::openvzve {
  include openvz::container
}
