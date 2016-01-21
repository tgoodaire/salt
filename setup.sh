#!/bin/sh
iface=`ifconfig | grep 192 | cut -d ' ' -f2`

echo "Installing salt master..."
pkg install py27-salt

echo "Configuring salt master..."
cat > /usr/local/etc/salt/master << EOF
interface: $iface
file_roots:
  base:
    - /srv/salt
EOF
sysrc salt_master_enable="YES"

echo "Starting salt master..."
/usr/local/etc/rc.d/salt_master restart

echo "Configuring salt minion..."
echo "master: $iface" > /usr/local/etc/salt/minion
sysrc salt_minion_enable="YES"

sleep 10

echo "Starting salt minion..."
/usr/local/etc/rc.d/salt_minion restart

sleep 10

echo "Accepting key and you're done...!"
salt-key -A

echo "You should be able to run a high state now!"
