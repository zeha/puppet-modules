# vim:set syntax=puppet tw=0 ts=2 sts=2:
import "*"

class zsh {

	package { "zsh":
		ensure => installed
	}

	file { "/etc/zsh":
		ensure => "directory",
		mode => 0755,
		owner => root,
		group => root,
	}
	file { "/etc/zsh/zshrc":
		ensure => "present",
		mode => 0644,
		owner => root,
		group => root,
		source => "puppet:///zsh/zshrc",
	}
	file { "/etc/zsh/zshrc.local":
		ensure => "present",
		mode => 0644,
		owner => root,
		group => root,
		source => "puppet:///zsh/zshrc.local",
	}
	file { "/etc/zsh/zshenv":
		ensure => "present",
		mode => 0644,
		owner => root,
		group => root,
		source => "puppet:///zsh/zshenv",
	}

}

