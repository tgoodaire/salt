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

ntpdate:
  service.running:
    - enable: True
    - reload: True
