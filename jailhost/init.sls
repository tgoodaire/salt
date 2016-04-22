/etc/rc.conf.d/jailhost:
  file.managed:
    - user: root
    - mode: 0644
    - source: salt://jailhost/jail.template

ezjail:
  pkg.installed

/usr/local/etc/ezjail.conf:
  file.managed:
    - source: salt://jailhost/ezjail.conf.template
    - user: root
    - group: wheel

ezjail_running:
  service.enabled:
    - name: ezjail

/etc/rc.conf.d/ezjail:
  file.managed:
    - user: root
    - mode: 0644
    - source: salt://jailhost/ezjail.template

{% for (host,hostdetail) in pillar.get('hosts', {}).items() %}
{% if 'jailhost' in hostdetail.keys() and hostdetail['jailhost'] == grains['host'] %}
check_jail_{{ host }}:
  module.run:
    - name: jail.status
    - jail: 
        {{ host }}

Create_{{ host }}_if_needed:
  cmd.run:
    - name: "/usr/local/bin/ezjail-admin create -a /usr/jails/ezjail_archives/minion.tar.gz {{ host }} {{ hostdetail['ip'] }}"
    - unless: test -d /usr/jails/{{ host }}

Start_ezjail_for_{{ host }}_if_needed:
  cmd.wait:
    - name: "ezjail-admin start {{ host }}"
    - watch:
      - cmd: Create_{{ host }}_if_needed
{% endif %}
{% endfor %}
