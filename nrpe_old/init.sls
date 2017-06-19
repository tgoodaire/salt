nrpe:
  pkg.latest:
    - fromrepo: local

nrpe_running:
  service.running:
    - enable: False
    - restart: True
    - name: nrpe2
    - watch:
      - file: /usr/local/etc/nrpe.cfg

/etc/rc.conf.d/nrpe2:
  file.managed:
    - user: root
    - mode: 0644
    - source: salt://nrpe/nrpe.template

/usr/local/etc/nrpe.cfg:
  file.managed:
    - user: root
    - mode: 0644
    - source: salt://nrpe/nrpe.cfg.template
    - template: jinja
