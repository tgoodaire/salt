/etc/ntp/ntp.conf:
  file.managed:
    - source: salt://files/system/ntp.conf
    - user: root
    - group: wheel

ntpd:
  service.running:
    - enable: True
    - reload: True
    - watch:
      - file: /etc/ntp/ntp.conf

/etc/rc.conf.d/ntp:
  file.managed:
    - user: root
    - mode: 0644
    - source: salt://ntp/ntp.template
