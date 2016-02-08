/usr/local/etc/sudoers.d/sudoers_custom:
  file.managed:
  - source: salt://files/system/sudoers_custom
  - user: root
