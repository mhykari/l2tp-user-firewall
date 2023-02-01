	#!/bin/sh
	echo "Start to lunch ... "

	# Set Variables
	# Set Linux username and Password
	LUSR=System-Username
	LPSW=System-User-Pass

	# L2TP Serever Source URL ***Dont Touch These***
	LURL=https://github.com/hwdsl2/setup-ipsec-vpn/archive/refs/heads/master.zip

	# L2TP Serever Variables ***Dont Touch These***
	SIPS="YOUR_IPSEC_PSK=''"
	SUSR="YOUR_USERNAME=''"
	SPSW="YOUR_PASSWORD=''"

	# Set Your PSK,Username and Paswweord
	DIPS="YOUR_IPSEC_PSK='Your L2TP Server PSK'"
	DUSR="YOUR_USERNAME='Your L2TP Account Username'"
	DPSW="YOUR_PASSWORD='Your L2TP Account Password'"

	create_user() {
	printf "\n\n *** Add User $LUSR To Linux *** \n\n\n"

	adduser --shell /bin/bash --gecos "Full Name,RoomNumber,WorkPhone,HomePhone" --disabled-password $LUSR
	echo "$LUSR:123456" | sudo chpasswd

	printf "\n\n *** User $LUSR Added *** \n\n\n"
	}

	download_bash_file() {
	printf "\n\n *** Downloading L2TP Bash File *** \n\n\n"

	mkdir -p /home/$LUSR/l2tp-server && cd /home/$LUSR/l2tp-server
	#apt update
	apt install zip
	wget $LURL
	unzip master.zip

	printf "\n\n *** L2TP Bash File Saved To /home/$LUSR/l2tp-server/ *** \n\n\n"
	}

	install_vpn_server() {
	printf "\n\n *** Installing L2TP Server *** \n\n\n"

	cd setup-ipsec-vpn-master
	sed -i "s/$SIPS/$DIPS/g" vpnsetup_ubuntu.sh && sed -i "s/$SUSR/$DUSR/g" vpnsetup_ubuntu.sh && sed -i "s/$SPSW/$DPSW/g" vpnsetup_ubuntu.sh
	bash vpnsetup_ubuntu.sh

	printf "\n\n *** L2TP Server Installed and Started *** \n\n\n"
	}

	update_firewall() {
	printf "\n\n *** Updating ufw Firewall Rules *** \n\n\n"

	# Install ufw Firewall
	apt install ufw
	# Put your firewall ports to allow input
	ufw allow 22 && ufw allow 80 && ufw allow 443
	# Put your firewall ports to deny out
	ufw deny out from any to 0.0.0.0/8
	ufw deny out from any to 10.0.0.0/8
	ufw deny out from any to 100.64.0.0/10
	ufw deny out from any to 169.254.0.0/16
	ufw deny out from any to 172.16.0.0/12
	ufw deny out from any to 192.0.0.0/24
	ufw deny out from any to 192.0.2.0/24
	ufw deny out from any to 192.88.99.0/24
	ufw deny out from any to 192.168.0.0/16
	ufw deny out from any to 198.18.0.0/15
	ufw deny out from any to 198.51.100.0/24
	ufw deny out from any to 203.0.113.0/24
	ufw deny out from any to 224.0.0.0/4
	ufw deny out from any to 24.0.0.0/4
	# Print Rules
	ufw status
	ufw enable
	#echo "y" | ufw enable

	printf "\n\n *** Firewall Updated and Enabled *** \n\n\n"
	}

	serversetup() {
	  create_user
	  download_bash_file
	  install_vpn_server
	  update_firewall
	}

	## Defer setup until we have the complete script
	serversetup "$@"

	echo "***Done***"