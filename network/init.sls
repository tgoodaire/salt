{% for host,hostdetail in pillar.get('hosts', {}).items() %}{% if 'jailhost' in hostdetail.keys() and hostdetail['jailhost'] == grains['host'] %}
ifconfig wlan0 {{ hostdetail['ip'] }} netmask 255.255.255.0 alias:
  cmd.run
{% endif %}{% endfor %}

/etc/rc.conf.d/network:
  file.managed:
    - user: root
    - mode: 0644
    - source: salt://network/network.template
    - template: jinja
