dnsmasq:
  pkg.latest

/usr/local/etc/dnsmasq.conf.d:
  file.directory:
    - user: root
    - group: wheel
    - mode: 755
    - makedirs: True

/usr/local/etc/dnsmasq.conf:
  file.managed:
    - source: salt://dnsmasq/dnsmasq.conf.template
    - user: root
    - group: wheel
    - template: jinja

/usr/local/etc/dnsmasq.conf.d/hosts.conf:
  file.managed:
    - source: salt://dnsmasq/hosts.conf.template
    - user: root
    - group: wheel
    - template: jinja

/usr/local/etc/dnsmasq.conf.d/extrahosts.conf:
  file.managed:
    - source: salt://dnsmasq/extrahosts.conf.template
    - user: root
    - group: wheel
    - template: jinja

dnsmasq_running:
  service.running:
    - restart: True
    - name: dnsmasq
    - watch:
      - file: /usr/local/etc/dnsmasq.conf
      - file: /usr/local/etc/dnsmasq.conf.d/hosts.conf
      - file: /usr/local/etc/dnsmasq.conf.d/extrahosts.conf

/etc/rc.conf.d/dnsmasq:
  file.managed:
    - user: root
    - mode: 0644
    - source: salt://dnsmasq/dnsmasq.template
