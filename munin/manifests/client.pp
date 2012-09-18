class munin::client {
  # libwww-perl is required for apache/lighttpd plugins
  package { "libwww-perl":
    ensure  => installed
  }
  package { "munin-node":
    ensure  => "installed",
    require => Package["libwww-perl"]
  }

  # disable cronjob which just updates the APT plugin stuff
  file { "/etc/cron.d/munin-node":
    ensure  => "absent"
  }

  file { ["/etc/munin", "/etc/munin/plugins"]:
    ensure  => directory,
    mode    => "0755"
  }

  file { "/etc/munin/plugin-conf.d":
    ensure  => directory,
    mode    => "0750"
  }

  $munin_node_allow_from = ymllookup("munin_node_allow_from")
  $munin_node_listen_host = ymllookup("munin_node_listen_host")
  file { "/etc/munin/munin-node.conf":
    mode    => "0640",
    ensure  => "present",
    notify  => Service["munin-node"],
    before  => Package["munin-node"],
    content => template("munin/munin-node.conf.erb")
  }

  service { "munin-node":
    ensure  => running,
    require => Package["munin-node"]
  }

  $munin_group = ymllookup("munin_group")
  @@file { "/etc/munin/munin-conf.d/${fqdn}":
    ensure  => present,
    tag     => "munin",
    owner   => "munin",
    mode    => 0600,
    content => "[${munin_group};$fqdn]\n  address $fqdn\n  use_node_name yes\n"
  }
}

define munin::plugin( $basename = false, $ensure = 'present', $config = false, $source = false)
{
  $basename_real = $basename ? { false => "$name", default => $basename }
  $plugin_conf   = "/etc/munin/plugin-conf.d/$basename_real"

  case $ensure {
    "present": {
      file { "/etc/munin/plugins/${name}":
        ensure => "/usr/share/munin/plugins/${basename_real}",
        notify => Service["munin-node"],
      }
      if $require {
        File["/etc/munin/plugins/${name}"] {
          require +> $require,
        }
      }
    }
    "absent": {
      file { "/etc/munin/plugins/${name}":
        ensure => "absent",
        notify => Service["munin-node"],
      }
    }
  }

  case $config {
    false: {}
    default: {
      if ! defined(File[$plugin_conf]) {
        file { $plugin_conf:
          ensure  => present,
          owner   => "root",
          group   => "munin",
          mode    => 0640,
          content => "[${basename_real}]\n${config}\n",
        }
      }
    }
  }

  case $source {
    false: {}
    default: {
      # deploy the plugin file only once.
      if ! defined(File["/usr/share/munin/plugins/${basename_real}"])
      {
        file { "/usr/share/munin/plugins/${basename_real}":
          ensure => $ensure,
          mode   => 0755,
          source => $source
        }
      }
      File["/etc/munin/plugins/${name}"] {
        require +> File["/usr/share/munin/plugins/${basename_real}"]
      }
    }
  }
}
