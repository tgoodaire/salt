# This state installs the tim user
# as well as all of my favourite packages
zsh:
  pkg.latest

vim:
  pkg.latest:
    - fromrepo: local

sudo:
  pkg.latest:
    - fromrepo: local

screen:
  pkg.latest:
    - fromrepo: local

git:
  pkg.latest

pkg_cutleaves:
  pkg.latest:
    - fromrepo: local

# User tim
tim:
   user.present:
    - fullname: Tim Goodaire
    - shell: /usr/local/bin/zsh
    - home: /home/tim
    - uid: 1001
    - groups:
      - wheel
    - password: $6$iPteN1DdPYzEcBHy$3H9vW0d41aWFagbmAIVkg/T1JLDWMgIpfdpO3Biyp0dZ4/oCVZHjR.JKKsjWdmPxvQSNB31ryq1U2xTxbiLvt.

# config files
/home/tim/.vim:
  file.recurse:
    - source: salt://files/tim/vim
    - user: tim
    - group: tim

/home/tim/.vimrc:
  file.managed:
    - source: salt://files/tim/vimrc
    - user: tim
    - group: tim

#FIXME: Install or update oh-my-zsh with git
/home/tim/.oh-my-zsh:
  file.recurse:
    - source: salt://files/tim/oh-my-zsh
    - user: tim
    - group: tim

/home/tim/.zshrc:
  file.managed:
    - source: salt://files/tim/zshrc
    - user: tim
    - group: tim

# This should be a magical template
# that somehow knows about all of
# the hosts that I want to know
# about.
/home/tim/.hosts:
  file.managed:
    - source: salt://files/tim/hosts
    - user: tim
    - group: tim

/etc/periodic.conf:
  file.managed:
    - source: salt://files/system/periodic.conf
    - user: root

/etc/make.conf:
  file.managed:
    - source: salt://files/system/make.conf
    - user: root

# User root
root:
  user.present:
    - fullname: Salty Root
    - shell: /bin/sh
    - home: /root
    - uid: 0
    - gid: 0
    - groups:
      - wheel
      - operator
    - password: $6$iPteN1DdPYzEcBHy$3H9vW0d41aWFagbmAIVkg/T1JLDWMgIpfdpO3Biyp0dZ4/oCVZHjR.JKKsjWdmPxvQSNB31ryq1U2xTxbiLvt.
