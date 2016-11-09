/usr/local/bin/finish_upgrade.sh:
  file.managed:
    - source: salt://upgrade_system/finish_upgrade.sh.template
    - user: root
    - group: wheel

/usr/local/bin/svnup release:
  cmd.run

make buildworld:
  cmd.run:
    - cwd: /usr/src

make buildkernel KERNCONF=DAHMER:
  cmd.run:
    - cwd: /usr/src

echo "You should reboot now and run finish_upgrade.sh":
  cmd.run
