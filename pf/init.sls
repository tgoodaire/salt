# Packages
#security/py-fail2ban:
#  ports.installed

/etc/pf.conf:
  file.managed:
    - source: salt://files/system/pf.conf
    - user: root
    - group: wheel

/etc/rc.conf.d/pf:
  file.managed:
    - source: salt://files/system/pf

pf:
  service.running:
    - enable: True
    - restart: True
    - watch:
      - file: /etc/pf.conf
 
#/usr/local/etc/fail2ban/jail.d/ssh-pf.local:
#  file.managed:
#    - source: salt://files/system/ssh-pf.conf
#    - user: root
#    - group: wheel

#/usr/local/etc/fail2ban/action.d/pf.conf:
#   file.managed:
#    - source: salt://files/system/fail2ban_pf.conf
#    - user: root
#    - group: wheel

# Add to /etc/rc.conf
# pf_enable="YES"
# fail2ban_enable="YES"
