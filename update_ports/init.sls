poudriere:
  pkg.installed

dialog4ports:
  pkg.installed

/data/lake/poudriere:
  file.directory:
    - user: root
    - group: wheel
    - dir_mode: 755
    - recurse:
      - user
      - group

/usr/local/etc/poudriere.d/make.conf:
  file.managed:
    - user: root
    - mode: 0644
    - source: salt://update_ports/make.conf.template
    - template: jinja

/usr/local/etc/poudriere.conf:
  file.managed:
    - user: root
    - mode: 0644
    - source: salt://update_ports/poudriere.conf.template
    - template: jinja

/usr/local/etc/buildlist:
  file.managed:
    - user: root
    - mode: 0644
    - source: salt://update_ports/buildlist.template

build_pkg_jail:
  module.run:
    - name: poudriere.create_jail
    - m_name: poudriere
    - arch: i386
    - version: 11.0-RELEASE
    - kwargs: {
          arch=i386,
          version=11.0-RELEASE
      }

update_ports:
  module.run:
    - name: poudriere.update_ports_tree
    - m_name: ports
    - ports_tree: default

build_ports:
  module.run:
    - name: poudriere.bulk_build
    - m_name: poudriere
    - pkg_file: /usr/local/etc/buildlist
    - jail: poudriere

