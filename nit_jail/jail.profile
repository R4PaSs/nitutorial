# Nit exec profile

include /etc/firejail/disable-mgmt.inc
include /etc/firejail/disable-secret.inc
include /etc/firejail/disable-common.inc
#include /etc/firejail/disable-terminals.inc

blacklist ${HOME}/.pki/nssdb
blacklist ${HOME}/.lastpass
blacklist ${HOME}/.keepassx
blacklist ${HOME}/.password-store


caps.drop all
seccomp
net none
noroot
shell none

private
private-bin false,true
private-dev
private-etc passwd,group
private-tmp

rlimit-fsize 10240
rlimit-nproc 1000
rlimit-nofile 500
rlimit-sigpending 200

env PATH=/usr/bin