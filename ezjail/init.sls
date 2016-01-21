# This state installs the tim user
# as well as all of my favourite packages

# Packages
sysutils/ezjail:
  ports.installed

/usr/local/etc/ezjail.conf:
  file.managed:
    - source: salt://files/system/ezjail.conf
    - user: root
    - group: wheel

# Add to /etc/rc.conf
# cloned_interfaces="lo1"
# ezjail_enable="YES"

# service netif cloneup
# service ezjail start
