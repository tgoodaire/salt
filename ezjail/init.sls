sysutils/ezjail:
  ports.installed

/usr/local/etc/ezjail.conf:
  file.managed:
    - source: salt://files/system/ezjail.conf
    - user: root
    - group: wheel

ezjail:
  service.enabled

/etc/rc.conf.d/ezjail:
  file.managed:
    - user: root
    - mode: 0644
    - source: salt://ezjail/ezjail.template

{% for (host,ip) in pillar.get(grains['fqdn'], {}).items() %}
check_jail_{{ host }}:
  module.run:
    - name: jail.status
    - jail: 
        {{ host }}

Create_{{ host }}_if_needed:
  cmd.run:
    - name: "/usr/local/bin/ezjail-admin create -a /usr/jails/ezjail_archives/minion.tar.gz {{ host }} {{ ip }}"
    - unless: test -d /usr/jails/{{ host }}

Start_ezjail_for_{{ host }}_if_needed:
  cmd.wait:
    - name: "ezjail-admin start {{ host }}"
    - watch:
      - cmd: Create_{{ host }}_if_needed

{% endfor %}
