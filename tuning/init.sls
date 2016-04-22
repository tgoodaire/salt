# FIXME: Should suggest if reboot needed or whatever
#/boot/loader.conf:
#  file.managed:
#    - source: salt://files/system/loader.conf
#    - user: root
#    - group: wheel

# rc.conf (rc.conf.local?)
# sysctl.conf
# ???

ca_root_nss:
  pkg.installed

openssl:
  pkg.installed
    
svnup:
  pkg.installed

/usr/local/etc/svnup.conf:
  file.managed:
    - source: salt://files/system/svnup.conf
    - user: root
    - group: wheel
