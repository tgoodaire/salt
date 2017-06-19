nginx:
  pkg.installed

rsync:
  pkg.installed

/usr/local/etc/nginx/nginx.conf:
  file.managed:
    - user: root
    - mode: 0644
    - source: salt://pkg_server/nginx.conf.template
    - template: jinja

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

www:
  user.present:
    - groups:
      - wheel

#FIXME: Status page url

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

#/var/synth/live_packages_tmp:
#  file.directory:
#    - user: www
#    - mode: 0755
#    - makedirs: True
#    - recurse:
#      - user

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

build_pkgs:
  cmd.run:
    - name: /usr/local/bin/synth just-build /usr/local/etc/buildlist
    - env:
      - TERM=ansi
#    - onlyif: 'test -e /data/REBUILD'

rebuild_repo:
  cmd.wait:
    - name: /usr/local/bin/synth rebuild-repository
    - env:
      - TERM=ansi
    - watch:
      - build_pkgs
#
#rsync_repo:
#  cmd.wait:
#    - name: /usr/local/bin/rsync -avp /var/synth/live_packages_tmp /var/synth/live_packages
#    - watch:
#      - rebuild_repo

#/data/REBUILD:
#  file.absent:
#    - watch:
#      - rsync_repo

/data:
  file.directory:
    - user: www
    - mode: 0755
    - makedirs: True
    - recurse:
      - user

Chown_pkgdirs:
  file.directory:
    - name: /var/synth
    - user: www
    - mode: 0755
    - makedirs: True
    - recurse:
      - user

Lame_chown:
  cmd.run:
    - name: "chmod -R 755 /data"
    - env:
      - TERM=ansi
