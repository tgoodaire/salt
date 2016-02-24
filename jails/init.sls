{% for (host,ip) in pillar.get(grains['fqdn'], {}).items() %}
  {% if ip not in grains['ip4_interfaces'].wlan0 %}
# {{ ip }}_rc_conf:
ifconfig wlan0 {{ ip }} netmask 255.255.255.0 alias:
    cmd.run
{% endif %}

# FIXME
# Ensure all IPs are aliases in rc.conf
# And that they're up
# See if there's a jail with that name and ip
# Otherwise, create it and start it

# a_{{ host }}:
#   - name: /tmp/foo
#   - cmd.run: echo {{ host }} {{ ip }} >> /tmp/foo

{% endfor %}
