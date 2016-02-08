sysutils/ezjail:
  ports.installed

/usr/local/etc/ezjail.conf:
  file.managed:
    - source: salt://files/system/ezjail.conf
    - user: root
    - group: wheel

ezjail:
  service.enabled

# Add to /etc/rc.conf
# cloned_interfaces="lo1"
# ezjail_enable="YES"

# service netif cloneup
# service ezjail start
