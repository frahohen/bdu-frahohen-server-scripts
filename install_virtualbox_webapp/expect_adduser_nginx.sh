#!/usr/bin/expect

set password [lindex $argv 0]

spawn su root -c "adduser phpvirtualbox-webgui"
 
expect "Geben Sie ein neues Passwort ein:"
send "$password\n"

expect "Geben Sie das neue Passwort erneut ein:"
send "$password\n"

expect "Vollständiger Name []:"
send "phpvirtualbox-webgui\n"

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
