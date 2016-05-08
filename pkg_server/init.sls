synth:
  pkg.latest

nginx:
  pkg.latest

/usr/local/etc/nginx/nginx.conf:
  file.managed:
    - user: root
    - mode: 0644
    - source: salt://pkg_server/nginx.conf.template
    - template: jinja

/var/db/ports/editors_vim:
  file.directory:
    - user: root
    - mode: 0644
    - makedirs: True

/var/db/ports/editors_vim/options:
  file.managed:
    - user: root
    - mode: 0644
    - source: salt://pkg_server/editors_vim_options.template

/var/db/ports/java_openjdk8:
  file.directory:
    - user: root
    - mode: 0644
    - makedirs: True

/var/db/ports/java_openjdk8/options:
  file.managed:
    - user: root
    - mode: 0644
    - source: salt://pkg_server/java_openjdk8_options.template

/var/db/ports/graphics_cairo/options:
  file.managed:
    - user: root
    - mode: 0644
    - source: salt://pkg_server/graphics_cairo_options.template

/etc/rc.conf.d/nginx:
  file.managed:
    - user: root
    - mode: 0644
    - source: salt://pkg_server/nginx.template

nginx_running:
  service.running:
    - name: nginx
    - enable: True
    - restart: True
    - watch:
      - file: /usr/local/etc/nginx/nginx.conf

/usr/local/etc/synth:
  file.directory:
    - user: root
    - mode: 0644
    - makedirs: True

/var/synth/distfiles:
  file.directory:
    - user: root
    - mode: 0644
    - makedirs: True

/usr/local/etc/synth/synth.ini:
  file.managed:
    - user: root
    - mode: 0644
    - source: salt://pkg_server/synth.ini.template

/usr/local/etc/synth/LiveSystem-make.conf:
  file.managed:
    - user: root
    - mode: 0644
    - source: salt://pkg_server/make.conf.template

/etc/make.conf:
  file.managed:
    - user: root
    - mode: 0644
    - source: salt://pkg_server/make.conf.template

#poudriere ports -c:
#  cmd.run:
#    - unless: ls /usr/local/poudriere/ports/default/Makefile

#poudriere ports -u:
#  cmd.run:
#    - require: ls /usr/local/poudriere/ports/default/Makefile
#
#poudriere jail -c -j buildhost -v 10.3-RELEASE:
#  cmd.run:
#    - require:
#      - file: /usr/local/etc/poudriere.conf

/usr/local/etc/buildlist:
  file.managed:
    - user: root
    - mode: 0644
    - source: salt://pkg_server/buildlist.template

/usr/local/etc/pkg/repos/00_synth.conf:
  file.absent

#synth just-build /usr/local/etc/build.list:
#  cmd.run

# Update ports
# Create jail
# Set options for packages
# Generate package list
# Build all
# Kill jail
# mount this:
# /var/db/ports  /usr/local/etc/poudriere.d/options nullfs rw 0 0

# On clients
# Create /usr/local/etc/pkg/repos/custom.conf
# custom: {
#   url: "http://pkg_host/whatever",
#   enabled: yes,
# }
