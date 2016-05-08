postgresql95-server:
  pkg.latest

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
    - require:
      - file: /usr/local/pgsql/data
    - unless:
      - ls /usr/local/pgsql/data/postgresql.conf

postgresql:
  service.running:
    - enable: True
    - restart: True
    - watch:
      - file: /usr/local/pgsql/data/postgresql.conf
      - file: /usr/local/pgsql/data/pg_hba.conf

# FIXME: Add nagios user with password nagios


#FIXME: Need to add export jail_fish_parameters="allow.sysvipc=1"
#to jail config or postgres won't start

# watch postgresql.conf and pg_hba.conf and reload

/usr/local/pgsql/data/postgresql.conf:
  file.managed:
    - user: pgsql
    - mode: 0600
    - source: salt://postgres/postgresql.conf.template

/usr/local/pgsql/data/pg_hba.conf:
  file.managed:
    - user: pgsql
    - mode: 0600
    - source: salt://postgres/pg_hba.conf.template
