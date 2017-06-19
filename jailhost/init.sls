/etc/rc.conf.d/kld_list:
  file.managed:
    - user: root
    - root: 0644
    - source: salt://jailhost/kld_list.template

/etc/rc.conf.d/sysctl:
  file.managed:
    - user: root
    - root: 0644
    - source: salt://jailhost/sysctl.template

/etc/sysctl.conf:
  file.managed:
    - user: root
    - root: 0644
    - source: salt://jailhost/sysctl.conf.template

# FIXME: Don't want to do this all the damn time.
# Maybe cron it?
#/usr/local/bin/ezjail-admin update -P:
#  cmd.run

/etc/rc.conf.d/jailhost:
  file.managed:
    - user: root
    - mode: 0644
    - source: salt://jailhost/jail.template

ezjail:
  pkg.latest

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

/data:
  file.directory:
    - user: root
    - group: wheel
    - mode: 0755
    - makedirs: True

/usr/local/bin/destroy_jails.sh:
  file.managed:
    - user: root
    - mode: 0700
    - source: salt://jailhost/destroy_jails.sh.template

{% for (host,hostdetail) in pillar.get('hosts', {}).items() %}
{% if 'jailhost' in hostdetail.keys() and hostdetail['jailhost'] == grains['host'] %}
check_jail_{{ host }}:
  module.run:
    - name: jail.status
    - jail:
        {{ host }}

Create_datadir_for_{{ host}}_if_needed:
  file.directory:
    - name: "/data/{{host}}"
    - user: root
    - mode: 0644
    - makedirs: True

Create_{{ host }}_if_needed:
  cmd.run:
    - name: "/usr/local/bin/ezjail-admin create -a /usr/jails/ezjail_archives/minion.tar.gz {{ host }} {{ hostdetail['ip'] }}"
    - unless: test -d /usr/jails/{{ host }}

Mount_datadir_for_{{ host }}_if_needed:
  cmd.run:
    - name: "mount -t nullfs -o rw /data/{{ host }} /usr/jails/{{ host }}/data"
    - unless: "mount | grep -q /usr/jails/{{ host }}/data"

Start_ezjail_for_{{ host }}_if_needed:
  cmd.wait:
    - name: "ezjail-admin start {{ host }}"
    - watch:
      - cmd: Create_{{ host }}_if_needed

{% endif %}
{% endfor %}
