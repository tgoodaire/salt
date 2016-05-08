/etc/ntp/ntp.conf:
  file.managed:
    - source: salt://files/system/ntp.conf
    - user: root
    - group: wheel

ntpd:
  service.running:
    - reload: True
    - watch:
      - file: /etc/ntp/ntp.conf

/etc/rc.conf.d/ntpd:
  file.managed:
    - user: root
    - mode: 0644
    - source: salt://ntp/ntpd.template

/etc/localtime:
  file.managed:
    - user: root
    - mode: 0644
    - source: salt://ntp/localtime.template
