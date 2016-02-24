sysutils/ezjail:
  ports.installed

/usr/local/etc/ezjail.conf:
  file.managed:
    - source: salt://files/system/ezjail.conf
    - user: root
    - group: wheel

ezjail:
  service.enabled

/etc/rc.conf.d/ezjail:
  file.managed:
    - user: root
    - mode: 0644
    - source: salt://ezjail/ezjail.template

# Add to /etc/rc.conf
# cloned_interfaces="lo1"

# service netif cloneup
# service ezjail start
