# Packages
#sysutils/ezjail:
#  ports.installed

/etc/ssh/sshd_config:
  file.managed:
    - source: salt://files/system/sshd_config
    - user: root
    - group: wheel

sshd:
  service.running:
    - enable: True
    - reload: True
    - watch:
      - file: /etc/ssh/sshd_config

# Add to /etc/rc.conf
# cloned_interfaces="lo1"
# ezjail_enable="YES"

# service netif cloneup
# service ezjail start
