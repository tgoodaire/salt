nagios4:
  pkg.latest:
    - fromrepo: local

nginx:
  pkg.latest:
    - fromrepo: local

php56:
  pkg.latest:
    - fromrepo: local

fcgiwrap:
  pkg.latest:
    - fromrepo: local

/var/log:
  file.directory:
    - user: root
    - group: wheel
    - mode: 0771
    - makedirs: True

/etc/rc.conf.d/nagios:
  file.managed:
    - user: root
    - mode: 0644
    - source: salt://nagios/nagios.template

/etc/rc.conf.d/fcgiwrap:
  file.managed:
    - user: root
    - mode: 0644
    - source: salt://nagios/fcgiwrap.template

/etc/rc.conf.d/php_fpm:
  file.managed:
    - user: root
    - mode: 0644
    - source: salt://nagios/php_fpm.template

/usr/local/etc/php-fpm.conf:
  file.managed:
    - user: root
    - mode: 0644
    - source: salt://nagios/php-fpm.conf.template

/usr/local/etc/nagios:
  file.directory:
    - user: root
    - mode: 0755

/usr/local/etc/nagios/nagios.cfg:
  file.managed:
    - user: root
    - mode: 0755
    - source: salt://nagios/nagios.cfg.template

/usr/local/etc/nagios/cgi.cfg:
  file.managed:
    - user: root
    - mode: 0755
    - source: salt://nagios/cgi.cfg.template

/usr/local/etc/nagios/resource.cfg:
  file.managed:
    - user: root
    - mode: 0755
    - source: salt://nagios/resource.cfg.template

/usr/local/etc/nagios/objects/commands.cfg:
  file.managed:
    - user: root
    - mode: 0755
    - source: salt://nagios/commands.cfg.template

/usr/local/etc/nagios/objects/resource.cfg:
  file.managed:
    - user: root
    - mode: 0755
    - source: salt://nagios/resource.cfg.template

/usr/local/etc/nagios/objects/hosts.cfg:
  file.managed:
    - user: root
    - mode: 0755
    - source: salt://nagios/hosts.cfg.template
    - template: jinja

/usr/local/etc/nagios/objects/contacts.cfg:
  file.managed:
    - user: root
    - mode: 0755
    - source: salt://nagios/contacts.cfg.template

/usr/local/etc/nagios/objects/templates.cfg:
  file.managed:
    - user: root
    - mode: 0755
    - source: salt://nagios/templates.cfg.template

/usr/local/etc/nagios/objects/services.cfg:
  file.managed:
    - user: root
    - mode: 0755
    - source: salt://nagios/services.cfg.template

/usr/local/etc/nginx/htpasswd:
  file.managed:
    - user: www
    - mode: 0600
    - source: salt://nagios/htpasswd.template

/usr/local/www/nagios/config.inc.php:
  file.managed:
    - user: www
    - mode: 0600
    - source: salt://nagios/config.inc.php.template

nagios_server_running:
  service.running:
    - restart: True
    - name: nagios
    - watch:
      - file: /usr/local/etc/nagios/nagios.cfg
      - file: /usr/local/etc/nagios/resource.cfg
      - file: /usr/local/etc/nagios/objects/commands.cfg
      - file: /usr/local/etc/nagios/objects/hosts.cfg
      - file: /usr/local/etc/nagios/objects/contacts.cfg
      - file: /usr/local/etc/nagios/objects/templates.cfg
      - file: /usr/local/etc/nagios/objects/services.cfg

/etc/rc.conf.d/nginx:
  file.managed:
    - user: root
    - mode: 0644
    - source: salt://nagios/nginx.template

/usr/local/etc/nginx/nginx.conf:
  file.managed:
    - user: root
    - mode: 0644
    - source: salt://nagios/nginx.conf.template
    - template: jinja

/usr/local/etc/php.ini:
  file.managed:
    - user: root
    - mode: 0644
    - source: salt://nagios/php.ini.template

nginx_running:
  service.running:
    - name: nginx
    - restart: True
    - watch:
      - file: /usr/local/etc/nginx/nginx.conf
      - file: /usr/local/www/nagios/config.inc.php

fcgiwrap_running:
  service.running:
    - name: fcgiwrap
    - restart: True

php-fpm_running:
  service.running:
    - name: php-fpm
    - restart: True
    - watch:
      - file: /usr/local/etc/php.ini

chown -R www /usr/local/www/nagios:
  cmd.run
