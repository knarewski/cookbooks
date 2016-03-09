name             'hg_server'
maintainer       'Jaroslaw Rodak'
maintainer_email 'jaroslaw.rodak@hgintelligence.com'
license          'all_rights'
description      'Installs/Configures hg_server'
long_description 'Installs/Configures hg_server'
version          '1.0.0'

depends 'ssh_authorized_keys'
depends 'sudo'
depends 'mysql', '5.6.3'
depends 'nginx', "> 2.7.0"