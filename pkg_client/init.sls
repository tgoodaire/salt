/usr/local/etc/pkg.conf:
  file.managed:
    - user: root
    - mode: 0644
    - source: salt://pkg_client/pkg.conf.template

/usr/local/etc/pkg:
  file.directory:
    - user: root
    - mode: 0777
    - makedirs: True

/usr/local/etc/pkg/repos:
  file.directory:
    - user: root
    - mode: 0777
    - makedirs: True

/usr/local/etc/pkg/repos/local_repo.conf:
  file.managed:
    - user: root
    - mode: 0644
    - source: salt://pkg_client/local_repo.conf.template
    - template: jinja

#FIXME: Sort out what to do about upstream freebsd repo
/usr/local/etc/pkg/repos/FreeBSD.conf:
  file.managed:
    - user: root
    - mode: 0644
    - source: salt://pkg_client/FreeBSD.conf.template
