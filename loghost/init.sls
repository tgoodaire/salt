ruby:
  pkg.latest:
    - fromrepo: local

rbenv:
  pkg.latest:
    - fromrepo: local

rubygem-tzinfo:
  pkg.latest:
    - fromrepo: local

tzinfo-data:
  gem.installed

elasticsearch2:
  pkg.latest:
    - fromrepo: local

kibana45:
  pkg.latest:
    - fromrepo: local

nginx:
  pkg.latest:
    - fromrepo: local

rubygem-fluentd:
  pkg.latest:
    - fromrepo: local

rubygem-string-scrub:
  pkg.latest:
    - fromrepo: local

fluent-plugin-string-scrub:
  gem.installed

string-scrub:
  gem.installed:
    - version: 0.0.5

fluent-plugin-elasticsearch:
  gem.installed

fluent-plugin-record-reformer:
  gem.installed

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

/etc/rc.conf.d/nginx:
  file.managed:
    - user: root
    - mode: 0644
    - source: salt://loghost/nginx.template

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

/usr/local/etc/fluentd:
  file.directory:
    - user: root
    - mode: 0644
    - mkdirs: True

/usr/local/etc/fluentd/fluent.conf:
  file.managed:
    - user: root
    - mode: 0644
    - source: salt://loghost/fluent.conf.template
    - template: jinja

/usr/local/etc/nginx:
  file.directory:
    - user: root
    - mode: 0644
    - mkdirs: True

/usr/local/etc/nginx/nginx.conf:
  file.managed:
    - user: root
    - mode: 0644
    - source: salt://loghost/nginx.conf.template
    - template: jinja

elasticsearch_running:
  service.running:
    - restart: True
    - name: elasticsearch
    - watch:
      - file: /usr/local/etc/elasticsearch/elasticsearch.yml
      - file: /usr/local/etc/elasticsearch/logging.yml
      - file: /etc/rc.conf.d/elasticsearch

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

nginx_running:
  service.running:
    - restart: True
    - name: nginx
    - watch:
      - file: /etc/rc.conf.d/nginx
      - file: /usr/local/etc/nginx/nginx.conf
