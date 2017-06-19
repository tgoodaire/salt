zabbix32-server:
  pkg.latest

zabbix32-frontend:
  pkg.latest

nginx:
  pkg.latest:
    - fromrepo: local

/etc/rc.conf.d/zabbix:
  file.managed:
    - user: root
    - mode: 0644
    - source: salt://zabbix/zabbix.template

zabbix_server_running:
  service.running:
    - restart: True
    - name: zabbix_server

