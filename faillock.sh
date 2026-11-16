#!/bin/bash
sudo tee -a /usr/share/pam-configs/faillock << 'EOF' > /dev/null
Name: Lockout on failed logins  
Default: no  
Priority: 0  
Auth-Type: Primary 
Auth: 
	[default=die]  	 	pam_faillock.so authfail 
EOF

sudo tee -a /usr/share/pam-configs/faillock_notify << 'EOF' > /dev/null
Name: Notify on account lockout  
Default: no  
Priority: 1024  
Auth-Type: Primary  
Auth:  
	requisite  	 	pam_faillock.so preauth 
EOF

sudo tee -a /usr/share/pam-configs/faillock_reset << 'EOF' > /dev/null
Name: Reset lockout on success  
Default: no  
Priority: 0  
Auth-Type: Additional  
Auth:  
	required  	 	pam_faillock.so authsucc 
EOF

sudo pam-auth-update

echo "the script has finished"
