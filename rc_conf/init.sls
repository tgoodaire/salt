/etc/rc.conf:
  file.managed:
    - user: root
    - mode: 0644
    - source: salt://rc_conf/rc_conf.template
    - template: jinja

/etc/rc.conf.d/hostname:
  file.managed:
    - user: root
    - mode: 0644
    - source: salt://rc_conf/hostname.template
    - template: jinja
