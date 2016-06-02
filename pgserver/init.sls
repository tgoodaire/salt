/etc/rc.conf.d/postgresql:
  file.managed:
    - user: root
    - mode: 0644
    - source: salt://pgserver/postgresql.template

#/usr/local/pgsql/data:
#  file.directory:
#    - user: pgsql
#    - mode: 0700
#    - makedirs: True

include:
  - postgres

#/usr/local/etc/rc.d/postgresql oneinitdb:
#  cmd.run:
#    - require:
#      - file: /usr/local/pgsql/data
#    - unless:
#      - ls /usr/local/pgsql/data/postgresql.conf

#postgresql:
#  service.running:
#    - enable: True
#    - restart: True
#    - watch:
#      - file: /usr/local/pgsql/data/postgresql.conf
#      - file: /usr/local/pgsql/data/pg_hba.conf


#/usr/local/pgsql/data/postgresql.conf:
#  file.managed:
#    - user: pgsql
#    - mode: 0600
#    - source: salt://postgres/postgresql.conf.template

#/usr/local/pgsql/data/pg_hba.conf:
#  file.managed:
#    - user: pgsql
#    - mode: 0600
#    - source: salt://postgres/pg_hba.conf.template
