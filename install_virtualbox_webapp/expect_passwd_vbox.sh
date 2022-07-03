#!/usr/bin/expect

set password [lindex $argv 0]

spawn su root -c "passwd vbox"
 
expect "Geben Sie ein neues Passwort ein:"
send "$password\n"

expect "Geben Sie das neue Passwort erneut ein:"
send "$password\n"

expect eof
