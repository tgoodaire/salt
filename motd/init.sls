/etc/motd:
  file.managed:
    - user: root
    - mode: 0644
    - source: salt://motd/motd.template
    - template: jinja
 
