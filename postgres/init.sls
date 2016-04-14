databases/postgresql95-server:
  ports.installed

/etc/rc.conf.d/postgres:
  file.managed:
    - user: root
    - mode: 0644
    - source: salt://postgres/postgres.template

/usr/local/pgsql/data:
  file.directory:
    - user: pgsql
    - mode: 0700
    - makedirs: True

/usr/local/etc/rc.d/postgresql oneinitdb:
  cmd.run:
    - watch:
      - file: /usr/local/pgsql/data

postgresql:
  service.running:
    - enable: True
    - restart: True

#FIXME: Need to add export jail_fish_parameters="allow.sysvipc=1"
#to jail config or postgres won't start
