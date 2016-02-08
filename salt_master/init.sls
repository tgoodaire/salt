/usr/local/etc/salt/master:
  file.managed:
    - source: salt://files/system/salt_master.conf
    - user: root
    - group: wheel

salt_master:
  service.running:
    - enable: True
    - reload: True
    - watch:
      - file: /usr/local/etc/salt/master
