define apache::ssl::cert($ensure, $source) {
	case $ensure {
		present: {
			file { "/etc/apache2/ssl/${name}.pem":
				ensure  => present,
				owner   => "root",
				group   => "root",
				mode	=> 0640,
				source  => $source,
				require => [File["/etc/apache2/ssl"], Apache::Module["ssl"]],
				notify  => Exec["reload-apache"],
			}
		}
		absent: {
			file { "/etc/apache2/ssl/${name}.pem":
				ensure  => absent,
				require => File["/etc/apache2/ssl"],
				notify  => Exec["reload-apache"],
			}
		}
	}
}
