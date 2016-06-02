/etc/ntp.conf:
  file.managed:
    - source: salt://ntp/ntp.conf.template
    - user: root
    - group: wheel

ntpd:
  service.running:
    - restart: True
    - watch:
      - file: /etc/ntp.conf

/etc/rc.conf.d/ntpd:
  file.managed:
    - user: root
    - mode: 0644
    - source: salt://ntp/ntpd.template

