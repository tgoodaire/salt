security/sshguard:
  ports.installed

sshguard:
  service.running:
    - enable: True
    - reload: True

/etc/rc.conf.d/sshguard:
  file.managed:
    - user: root
    - mode: 0644
    - source: salt://security/sshguard.template
