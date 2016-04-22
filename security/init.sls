sshguard:
  pkg.installed

sshguard_running:
  service.running:
    - enable: True
    - reload: True
    - name: sshguard

/etc/rc.conf.d/sshguard:
  file.managed:
    - user: root
    - mode: 0644
    - source: salt://security/sshguard.template

/usr/local/etc/sshguard.whitelist:
  file.managed:
    - user: root
    - mode: 0644
    - source: salt://security/sshguard_whitelist.template
