#!/usr/bin/expect

spawn su root -c "apt install openssh-server -y"
 
expect "Override local changes to /etc/pam.d/common-*? "
send "no\n"

expect eof
