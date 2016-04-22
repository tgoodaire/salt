/usr/local/etc/pkg/repos:
  file.directory:
    - user: root
    - mode: 0644
    - makedirs: True

/usr/local/etc/pkg/repos/local_repo.conf:
  file.managed:
    - user: root
    - mode: 0644
    - source: salt://pkg_client/local_repo.conf.template
    - template: jinja
