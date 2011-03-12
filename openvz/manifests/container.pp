class openvz::container {
  # Containers can't really trust their mtab file, but /proc/mounts is
  # always correct.
  file { "/etc/mtab":
    ensure => "/proc/mounts",
  }
}
