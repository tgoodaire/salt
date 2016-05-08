#FIXME: Add log rotation, and delete obsolete log files
#FIXME: Make sure that all applications (postgres, etc)
#are logging to syslog.
syslog-ng_installed:
  pkg.installed:
  - name: syslog-ng

/usr/local/etc/syslog-ng.conf:
  file.managed:
    - user: root
    - mode: 0644
    - source: salt://logging/syslog-ng.conf.template
    - template: jinja

/etc/rc.conf.d/syslog:
  file.managed:
    - user: root
    - mode: 0644
    - source: salt://logging/syslog.template

/etc/rc.conf.d/syslog_ng:
  file.managed:
    - user: root
    - mode: 0644
    - source: salt://logging/syslog_ng.template

/etc/newsyslog.conf:
  file.managed:
    - user: root
    - mode: 0644
    - source: salt://logging/newsyslog.conf.template

syslogd:
  service.dead

syslog-ng:
  service.running:
    - restart: True
    - watch:
      - file: /usr/local/etc/syslog-ng.conf
