#include:
#  - nginx

nginx:
  pkg.latest

#libxslt:
#  pkg.latest

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

/var/db/ports/graphics_cairo:
  file.directory:
    - user: root
    - mode: 0644
    - makedirs: True

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

/data/synth:
  file.directory:
    - user: www
    - mode: 0755
    - makedirs: True
    - recurse:
      - user

/var/synth:
  file.symlink:
    - user: www
    - mode: 0755
    - target: /data/synth

/var/synth/distfiles:
  file.directory:
    - user: www
    - mode: 0755
    - makedirs: True
    - recurse:
      - user

/var/synth/live_packages:
  file.directory:
    - user: www
    - mode: 0755
    - makedirs: True
    - recurse:
      - user

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

synth:
  pkg.latest

/usr/local/etc/buildlist:
  file.managed:
    - user: root
    - mode: 0644
    - source: salt://pkg_server/buildlist.template

/usr/local/etc/pkg/repos/00_synth.conf:
  file.absent

/data:
  file.directory:
    - user: www
    - mode: 0755
    - makedirs: True
    - recurse:
      - user

Lame_chown:
  cmd.run:
    - name: "chmod -R 755 /data"
