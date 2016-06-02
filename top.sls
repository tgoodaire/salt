# SO this kind of sucks. Should ensure that if things aren't installed
# they should be removed...
# Need to figure out how to lay all of this out.
# roles:jail
# roles:saltmaster
# roles:jailhost
# base:
#   'roles:jail':
#     - match: pillar
#     - jail
#base:
#  '*':
#    - users
#    - sudoers
#    - sshd
#    - motd
#    - rc_conf
#    - network
#    - salt_minion

#  'dahmer*': 
#    - tuning
    # Disabled for now. Don't wanna run port update every time
    # - ports
#    - salt_master
    #- pf
#    - jails
#    - ezjail
#    - ntp

base:
  'os:FreeBSD':
    - match: grain
    - freebsd-defaults
           
  '*':
    - roles
