/usr/local/etc/salt/minion:
  file.managed:
    - source: salt://salt_minion/minion.template
    - user: root
    - group: wheel

salt_minion:
  service.running:
    - enable: True
    - restart: True
    - watch:
      - file: /usr/local/etc/salt/minion

/etc/rc.conf.d/salt_minion:
  file.managed:
    - user: root
    - mode: 0644
    - source: salt://salt_minion/salt_minion.template
