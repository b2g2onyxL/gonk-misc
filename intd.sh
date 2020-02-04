#!/system/bin/sh

log -p E "Enter intd.sh"

DEBUG=`getprop ro.debuggable`

log -p E "ro.debuggable : $DEBUG"

if [ "$DEBUG" == "1" ]; then

	log -p E "intd start sshd-server.js"

	cd /system/bin/node-javascript/ssh
	/system/bin/node  /system/bin/node-javascript/ssh/sshd-server.js &
	
	log -p E "intd start SSR-server.js"
	cd /
	/system/bin/node /system/bin/node-javascript/ssr/SSR-server.js
	

else
	log -p E "ro.debuggable !=1"
	
fi

