base:
  '*': 
    # Takes forever to run
    # - users
    # Only for freebsd master host thinger
    # - tuning
    - ezjail
    # Disabled for now. Don't wanna run port update every time
    # - ports
    # - sudoers
    - salt_master
    # - pf
    # - ssh
    - motd
    # - jails
    - rc_conf