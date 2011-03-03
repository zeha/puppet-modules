# vim:set syntax=puppet tw=0 ts=2 sts=2:

class vim {

	# Remove the minimal version of vim.
	package { "vim-tiny":
		ensure => "purged",
	}
	# And install the full-blown version.
	package { "vim":
		ensure => "installed",
	}
	# vimrc.local get's read from /etc/vimrc on Debian
	file { "/etc/vim/vimrc.local":
		require => Package["vim"],
		owner => "root",
		group => "root",
		mode => "0644",
		source => "puppet:///vim/vimrc.local",
		ensure => "present"
	}
	# ensure default editor is the one true cli editor
	file { "/etc/alternatives/editor":
		require => Package["vim"],
		ensure => "/usr/bin/vim.basic",
	}	
	
}
