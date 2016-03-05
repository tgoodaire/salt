{% for (host,ip) in pillar.get(grains['fqdn'], {}).items() %}
  {% if ip not in grains['ip4_interfaces'].wlan0 %}
ifconfig wlan0 {{ ip }} netmask 255.255.255.0 alias:
  cmd.run
{% endif %}
{% endfor %}

/etc/rc.conf.d/network:
  file.managed:
    - user: root
    - mode: 0644
    - source: salt://network/network.template
    - template: jinja
