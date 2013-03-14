define apache::site($ensure, $source = "", $content = "") {
	file { "/etc/apache2/sites-available/${name}":
		owner => "root",
		group => "root",
		mode => 0644,
		ensure => $ensure,
		require => [File["/etc/apache2/sites-available/"], Package["apache2"]],
		notify => [Service["apache2"]],
	}

	case $ensure {
		"present": {
			# see if we need to do source or content.
			case $content { 
				"": { File["/etc/apache2/sites-available/${name}"] { source => $source } }
				default: { File["/etc/apache2/sites-available/${name}"] { content => $content } }
			}

			file { "/etc/apache2/sites-enabled/${name}":
				owner => "root",
				group => "root",
				mode => 0644,
				ensure => "/etc/apache2/sites-available/${name}",
				require => [File["/etc/apache2/sites-available/${name}"], Package["apache2"]],
				notify => [Service["apache2"]],
			}
		}
		"absent": {
			file { "/etc/apache2/sites-enabled/${name}":
				ensure => absent
			}
		}
	}
}

