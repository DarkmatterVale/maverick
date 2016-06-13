class maverick-puppet::client (
) {

    package {["puppet", "facter", "hiera"]:
        ensure	=> installed
    }
    if ($operatingsystem == "Debian" or $operatingsystem == "Ubuntu") {
        package {["ruby-json"]:
            ensure	=> installed
        }
    }

    service {["puppet"]:
        ensure		=> "stopped",
        enable		=> false,
        require     => Package["puppet"],
    }
    file { "/etc/puppet/puppet.conf":
        ensure      => file,
        content     => template("maverick-puppet/puppet-client.conf.erb"),
        mode        => "644",
        owner       => "root",
        group       => "root",
    }

}
