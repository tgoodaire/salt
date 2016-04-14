{% for (host,hostdetail) in pillar.get('hosts', {}).items() -%}
{% if host == grains['nodename'] and hostdetail.has_key('roles') -%}
include:
{% for role in hostdetail['roles'] -%}
  - {{ role }}
{% endfor -%}
{% endif -%}
{% endfor -%}
