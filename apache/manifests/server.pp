class apache::server {
	if $apache_keepalive { $apache_keepalive = $apache_keepalive } else { $apache_keepalive = "On" }
	if $apache_maxkeepaliverequests { $apache_maxkeepaliverequests = $apache_maxkeepaliverequests } else { $apache_maxkeepaliverequests = "100" }
	if $apache_keepalivetimeout { $apache_keepalivetimeout = $apache_keepalivetimeout } else { $apache_keepalivetimeout = 15 }
	if $apache_mpm { $apache_mpm = $apache_mpm } else { $apache_mpm = "prefork" }
	if $apache_serverlimit { $apache_serverlimit = $apache_serverlimit } else { $apache_serverlimit = 512 }
	if $apache_maxclients { $apache_maxclients = $apache_maxclients } else { $apache_maxclients = 150 }
	if $apache_maxrequestsperchild { $apache_maxrequestsperchild = $apache_maxrequestsperchild } else { $apache_maxrequestsperchild = 0 }
	if $apache_listen_port80 { $apache_listen_port80 = $apache_listen_port80 } else { $apache_listen_port80 = true }
	if $apache_listen_ssl { $apache_listen_ssl = $apache_listen_ssl } else { $apache_listen_ssl = false }
	if $apache_arguments { $apache_arguments = $apache_arguments } else { $apache_arguments = "" }
	if $apache_listen	{ $apache_listen = $apache_listen } else { $apache_listen = ["*:80"] }

	case $apache_mpm {
		"prefork": {
			if $apache_startservers { $apache_startservers = $apache_startservers } else { $apache_startservers = 5 }
			if $apache_minspare { $apache_minspare = $apache_minspare } else { $apache_minspare = 5 }
			if $apache_maxspare { $apache_maxspare = $apache_maxspare } else { $apache_maxspare = 10 }
		}
		"worker": {
			if $apache_startservers { $apache_startservers = $apache_startservers } else { $apache_startservers = 2 }
			if $apache_minspare { $apache_minspare = $apache_minspare } else { $apache_minspare = 25 }
			if $apache_maxspare { $apache_maxspare = $apache_maxspare } else { $apache_maxspare = 75 }
			if $apache_threadsperchild { $apache_threadsperchild = $apache_threadsperchild } else { $apache_threadsperchild = 25 }
		}
		"event": {
			if $apache_startservers	{ $apache_startservers = $apache_startservers } else { $apache_startservers = 2 }
			if $apache_minspare		{ $apache_minspare = $apache_minspare } else { $apache_minspare = 25 }
			if $apache_maxspare		{ $apache_maxspare = $apache_maxspare } else { $apache_maxspare = 75 }
			if $apache_threadlimit	 { $apache_threadlimit = $apache_threadlimit } else { $apache_threadlimit = 64 }
			if $apache_threadsperchild { $apache_threadsperchild = $apache_threadsperchild } else { $apache_threadsperchild = 25 }
		}
	}

	package { "apache2":
		ensure       => installed,
	}

	service { "apache2":
		ensure	     => running,
		hasrestart   => true,
		hasstatus    => true,
		require	     => Package["apache2"],
	}

	user { "www-data":
		ensure       => present,
		shell        => "/bin/sh",
		require      => Package["apache2"],
	}

	group { "www-data":
		ensure       => present,
		require      => Package["apache2"],
	}

	exec { "reload-apache":
		command	     => "/usr/sbin/apache2ctl graceful",
		onlyif	     => "/usr/sbin/apache2ctl configtest",
		refreshonly  => true,
	}

	exec { "restart-apache":
		command	     => "/usr/sbin/apache2ctl restart",
		onlyif	     => "/usr/sbin/apache2ctl configtest",
		refreshonly  => true,
	}

	# for ssl certificates
	file { "/etc/apache2/ssl":
		ensure  => "directory",
		owner   => "root",
		group   => "root",
		mode	=> "0600",
		require => Package["apache2"],
	}
	
	# zap sites-available/enabled
	file { "/etc/apache2/sites-available":
		ensure  => directory,
		recurse => true,
		purge   => true,
		owner   => "root",
		group   => "root",
		mode	=> 0644,
		source  => "puppet:///modules/apache2/empty",
		require => Package["apache2"],
	}
	file { "/etc/apache2/sites-enabled":
		ensure  => directory,
		recurse => true,
		purge   => true,
		owner   => "root",
		group   => "root",
		mode	=> 0644,
		source  => "puppet:///modules/apache2/empty",
		require => Package["apache2"],
	}

	# deliver conf files
	File {
		owner   => "root",
		group   => "root",
		mode	=> 0644,
		require => Package["apache2"],
		notify  => Exec["reload-apache"],
	}

	file { 
		"/etc/apache2/apache2.conf":
			source  => "puppet:///modules/apache/apache2/apache2.conf";

		"/etc/apache2/httpd.conf":
			content => template("apache/httpd.conf.erb");

		"/etc/apache2/envvars":
			content => template("apache/envvars.erb");

		"/etc/apache2/conf.d/security":
			source  => "puppet:///modules/apache/apache2/conf.d/security";
	}

	file { "/srv/http":
		ensure  => directory,
		owner   => "root",
		group   => "root",
		mode	=> 0644,
	}
	
	munin::plugin { ["apache_accesses", "apache_processes", "apache_volume"]:
		ensure => "present",
	}
}

