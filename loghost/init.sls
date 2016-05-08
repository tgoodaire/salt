elasticsearch2:
  pkg.installed

kibana45:
  pkg.installed

#nginx:
#  pkg.installed

logstash:
  pkg.installed

rubygem-fluentd:
  pkg.installed

{% for (host,hostdetail) in pillar.get('hosts', {}).items() -%}
/var/log/{{ host }}.log:
  file.managed:
    - user: root
    - mode: 0640
{% endfor %}

/etc/rc.conf.d/logstash:
  file.managed:
    - user: root
    - mode: 0644
    - source: salt://loghost/logstash.template

/etc/rc.conf.d/elasticsearch:
  file.managed:
    - user: root
    - mode: 0644
    - source: salt://loghost/elasticsearch.template

/etc/rc.conf.d/kibana:
  file.managed:
    - user: root
    - mode: 0644
    - source: salt://loghost/kibana.template

#/etc/rc.conf.d/nginx:
#  file.managed:
#    - user: root
#    - mode: 0644
#    - source: salt://loghost/nginx.template

/etc/rc.conf.d/fluentd:
  file.managed:
    - user: root
    - mode: 0644
    - source: salt://loghost/fluentd.template

/usr/local/etc/kibana.yml:
  file.managed:
    - user: root
    - mode: 0644
    - source: salt://loghost/kibana.yml.template
    - template: jinja

/usr/local/etc/elasticsearch/elasticsearch.yml:
  file.managed:
    - user: root
    - mode: 0644
    - source: salt://loghost/elasticsearch.yml.template

/usr/local/etc/elasticsearch/logging.yml:
  file.managed:
    - user: root
    - mode: 0644
    - source: salt://loghost/logging.yml.template

/usr/local/etc/logstash/logstash.conf:
  file.managed:
    - user: root
    - mode: 0644
    - source: salt://loghost/logstash.conf.template

/usr/local/etc/fluentd/fluent.conf:
  file.managed:
    - user: root
    - mode: 0644
    - source: salt://loghost/fluent.conf.template
    - template: jinja

#/usr/local/etc/nginx/nginx.conf:
#  file.managed:
#    - user: root
#    - mode: 0644
#    - source: salt://loghost/nginx.conf.template

#/usr/local/etc/nginx/htpasswd.users:
#  file.managed:
#    - user: root
#    - mode: 0644
#    - source: salt://loghost/htpasswd.users.template

logstash_running:
  service.running:
    - restart: True
    - name: logstash
    - watch:
      - file: /etc/rc.conf.d/logstash
      - file: /usr/local/etc/logstash/logstash.conf

elasticsearch_running:
  service.running:
    - restart: True
    - name: elasticsearch
    - watch:
      - file: /usr/local/etc/elasticsearch/elasticsearch.yml
      - file: /usr/local/etc/elasticsearch/logging.yml
      - file: /etc/rc.conf.d/elasticsearch

nginx:
  service.dead

kibana_running:
  service.running:
    - restart: True
    - name: kibana
    - watch:
      - file: /etc/rc.conf.d/kibana
      - file: /usr/local/etc/kibana.yml

fluentd_running:
  service.running:
    - restart: True
    - name: fluentd
    - watch:
      - file: /etc/rc.conf.d/fluentd
      - file: /usr/local/etc/fluentd/fluent.conf
