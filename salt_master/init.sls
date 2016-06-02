/usr/local/etc/salt/master:
  file.managed:
    - source: salt://salt_master/master.template
    - user: root
    - group: wheel

salt_master:
  service.running:
    - enable: True
    - restart: True
    - watch:
      - file: /usr/local/etc/salt/master

/etc/rc.conf.d/salt_master:
  file.managed:
    - user: root
    - mode: 0644
    - source: salt://salt_master/salt_master.template
