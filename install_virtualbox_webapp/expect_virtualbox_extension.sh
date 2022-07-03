#!/usr/bin/expect

set latestVirtualBoxVersion [lindex $argv 0]

spawn su root -c "VBoxManage extpack install --replace Oracle_VM_VirtualBox_Extension_Pack-$latestVirtualBoxVersion.vbox-extpack"
 
expect "Do you agree to these license terms and conditions (y/n)?"
send "y\n"

expect eof
