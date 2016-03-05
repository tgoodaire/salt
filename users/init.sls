# This state installs the tim user
# as well as all of my favourite packages

# Packages
editors/vim:
  ports.installed:
    - options:
      - DEFAULT_VIMRC: off
      - PERL: off
      - PYTHON: off
      - RUBY: off
      - TCL: off
      - GTK2: off
      - CONSOLE: on

shells/zsh:
  ports.installed:
    - options:
      - DOCS: off
      - EXAMPLES: off

security/sudo:
  ports.installed:
    - options:
      - DOCS: off
      - INSULTS: on

sysutils/screen:
  ports.installed

devel/git:
  ports.installed:
    - options:
      - PERL: off

net/rsync:
  ports.installed:
    - options:
      - DOCS: off

# Global conf
/usr/local/etc/vim:
  file.directory:
    - user: root
    - group: wheel
    - mode: 755
    - makedirs: True

/usr/local/etc/vim/vimrc:
  file.managed:
    - source: salt://files/system/vimrc
    - user: root
    - group: wheel

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

# User root
root:
  user.present:
    - fullname: Salty Root
    - shell: /usr/local/bin/zsh
    - home: /root
    - uid: 0
    - gid: 0
    - groups:
      - wheel
      - operator
    - password: $6$iPteN1DdPYzEcBHy$3H9vW0d41aWFagbmAIVkg/T1JLDWMgIpfdpO3Biyp0dZ4/oCVZHjR.JKKsjWdmPxvQSNB31ryq1U2xTxbiLvt.
