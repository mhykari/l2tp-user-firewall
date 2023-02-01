# l2tp-user-firewall
Bash script to turn a linux server to l2tp server.
# Turn a Linux Server to L2TP Server
This is a bash script to turn you ubuntu server to a l2tp server with all dependencies using [hwdsl2](https://github.com/hwdsl2/setup-ipsec-vpn/)'s IPsec VPN Server Auto Setup Script and i just added automated user creation and ufw firewall install to import rules needed to protect users and server from netscan or other attacks.
# How to Use
This script has 4 steps:
1- create_user
2- download_bash_file
3- install_vpn_server
4- update_firewall

First of all put the variables needed in the script file.
Put your system username and password in as LUSR and LPSW.
Then Enter l2tp server information as DIPS, DUSR and DPSW included and described in file.
You can also add your input and output ufw firewall ports. The ports included as allow input traffic is 22,80 and 443 and deny output to all private ipv4 ranges to prevent netscan and other attacks.
