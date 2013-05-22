class acpi {
  case $lsbdistid {
    "Debian": {
      package { "acpi-support-base":
        ensure => installed
      }
    }
  }
}
