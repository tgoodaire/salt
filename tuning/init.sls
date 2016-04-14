# FIXME: Should suggest if reboot needed or whatever
#/boot/loader.conf:
#  file.managed:
#    - source: salt://files/system/loader.conf
#    - user: root
#    - group: wheel

# rc.conf (rc.conf.local?)
# make.conf
# sysctl.conf
# ???

/etc/make.conf:
  file.managed:
    - source: salt://files/system/make.conf
    - user: root
    - group: wheel

security/ca_root_nss:
  ports.installed

security/openssl:
  ports.installed:
    - options:
      - SHARED: on
      - THREADS: on
      - I386: off
      - SSE2: on
      - ASM: off
      - PADLOCK: off
      - ZLIB: off
      - GMP: off
      - SSL2: on
      - SSL3: on
      - RFC3779: off
      - MD2: off
      - RC5: off
      - EXPCIPHERS: off
      - DOCS: off
      - MAN3: off

net/svnup:
  ports.installed:
    - options:
      - DOCS: off

/usr/local/etc/svnup.conf:
  file.managed:
    - source: salt://files/system/svnup.conf
    - user: root
    - group: wheel
