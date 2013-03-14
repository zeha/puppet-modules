define apache::module($ensure) {
	case $ensure {
		"present": {
			exec { "/usr/sbin/a2enmod $name":
				unless  => "/bin/sh -c '[ -L /etc/apache2/mods-enabled/${name}.load ] \\
							&& [ /etc/apache2/mods-enabled/${name}.load -ef /etc/apache2/mods-available/${name}.load ]'",
				notify  => Exec["restart-apache"],
				require => $require ? {
					""	  => Package["apache2"],
					default => [ Package["apache2"], $require ],
				}
			}
		}
		"absent":  {
			exec { "/usr/sbin/a2dismod $name":
				onlyif  => "/bin/sh -c '[ -L /etc/apache2/mods-enabled/${name}.load ] \\
							&& [ /etc/apache2/mods-enabled/${name}.load -ef /etc/apache2/mods-available/${name}.load ]'",
				notify  => Exec["restart-apache"],
				require => $require ? {
					""	  => Package["apache2"],
					default => [ Package["apache2"], $require ],
				}
			}
		}
	}
}
