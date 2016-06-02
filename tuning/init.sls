# FIXME: Should suggest if reboot needed or whatever
#/boot/loader.conf:
#  file.managed:
#    - source: salt://files/system/loader.conf
#    - user: root
#    - group: wheel

# rc.conf (rc.conf.local?)
# sysctl.conf
# ???
# kldload tmpfs

ca_root_nss:
  pkg.latest:
    - fromrepo: local

openssl:
  pkg.latest:
    - fromrepo: local

svnup:
  pkg.latest:
    - fromrepo: local

/usr/local/etc/svnup.conf:
  file.managed:
    - source: salt://files/system/svnup.conf
    - user: root
    - group: wheel
