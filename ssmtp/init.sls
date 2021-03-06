/etc/rc.conf.d/ssmtp:
  file.managed:
    - source: salt://ssmtp/ssmtp.conf.template
    - user: root
    - group: wheel
    - template: jinja

sendmail:
  service.dead

ssmtp:
  pkg.latest:
    - fromrepo: local

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
