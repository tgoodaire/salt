#FixME: Move all of these files into this dir

/boot/loader.conf:
  file.managed:
    - source: salt://files/system/loader.conf
    - user: root
    - group: wheel

/usr/src/sys/i386/conf/DAHMER:
  file.managed:
    - source: salt://files/system/DAHMER
    - user: root
    - group: wheel

# rc.conf (rc.conf.local?)
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
