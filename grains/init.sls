/usr/local/etc/salt/grains:
  file.managed:
    - source: salt://grains/grains.template
    - user: root
    - group: wheel
    - template: jinja
