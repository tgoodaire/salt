/etc/rc.conf.d/ssmtp:
  file.managed:
    - source: salt://ssmtp/ssmtp.conf.template
    - user: root
    - group: wheel
    - template: jinja

sendmail:
  service.running:
    - enable: False

mail/ssmtp:
  ports.installed

/usr/local/etc/ssmtp/ssmtp.conf:
  file.managed:
    - source: salt://ssmtp/ssmtp_config.conf.template
    - user: root
    - group: wheel
    - template: jinja

/etc/mail/mailer.conf:
  file.managed:
    - source: salt://ssmtp/mailer.conf.template
    - user: root
    - group: wheel
    - template: jinja


