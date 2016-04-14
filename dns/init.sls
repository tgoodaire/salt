/etc/resolv.conf:
  file.managed:
    - user: root
    - mode: 0644
    - source: salt://dns/resolv.conf.template
    - template: jinja
