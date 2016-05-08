/etc/rc.conf.d/ssmtp:
  file.managed:
    - source: salt://ssmtp/ssmtp.conf.template
    - user: root
    - group: wheel
    - template: jinja

sendmail:
  service.running:
    - enable: False

ssmtp:
  pkg.latest

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

/etc/aliases:
  file.managed:
    - source: salt://ssmtp/aliases.template
    - user: root
    - group: wheel
    - template: jinja

newaliases:
  cmd.wait:
    - watch:
      - file: /etc/aliases
