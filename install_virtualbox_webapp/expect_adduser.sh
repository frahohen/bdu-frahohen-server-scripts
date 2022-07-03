#!/usr/bin/expect

set user [lindex $argv 0]
set password [lindex $argv 1]

spawn su root -c "adduser $user"
 
expect "Geben Sie ein neues Passwort ein:"
send "$password\n"

expect "Geben Sie das neue Passwort erneut ein:"
send "$password\n"

expect "Vollständiger Name []:"
send "$user\n"

expect "Zimmernummer []:"
send "\n"

expect "Telefon geschäftlich []:"
send "\n"

expect "Telefon privat []:"
send "\n"

expect "Sonstiges []:"
send "\n"

expect "Sind die Informationen korrekt?"
send "J\n"

expect eof
