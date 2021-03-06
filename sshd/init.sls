/etc/ssh/sshd_config:
  file.managed:
    - source: salt://sshd/sshd_config.template
    - user: root
    - group: wheel
    - template: jinja

sshd:
  service.running:
    - enable: True
    - restart: True
    - watch:
      - file: /etc/ssh/sshd_config

/etc/rc.conf.d/sshd:
  file.managed:
    - user: root
    - mode: 0644
    - source: salt://sshd/sshd.template
