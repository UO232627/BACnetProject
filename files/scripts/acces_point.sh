#!/bin/bash
sudo apt install -y hostapd

sudo systemctl unmask hostapd
sudo systemctl enable hostapd

sudo apt install -y dnsmasq

sudo DEBIAN_FRONTEND=noninteractive apt install -y netfilter-persistent iptables-persistent

sudo cat > /etc/dhcpcd.conf << EOF
# A sample configuration for dhcpcd.
# See dhcpcd.conf(5) for details.

# Allow users of this group to interact with dhcpcd via the control socket.
#controlgroup wheel

# Inform the DHCP server of our hostname for DDNS.
hostname

# Use the hardware address of the interface for the Client ID.
clientid
# or
# Use the same DUID + IAID as set in DHCPv6 for DHCPv4 ClientID as per RFC4361.
# Some non-RFC compliant DHCP servers do not reply with this set.
# In this case, comment out duid and enable clientid above.
#duid

# Persist interface configuration when dhcpcd exits.
persistent

# Rapid commit support.
# Safe to enable by default because it requires the equivalent option set
# on the server to actually work.
option rapid_commit

# A list of options to request from the DHCP server.
option domain_name_servers, domain_name, domain_search, host_name
option classless_static_routes
# Respect the network MTU. This is applied to DHCP routes.
option interface_mtu

# Most distributions have NTP support.
#option ntp_servers

# A ServerID is required by RFC2131.
require dhcp_server_identifier

# Generate SLAAC address using the Hardware Address of the interface
#slaac hwaddr
# OR generate Stable Private IPv6 Addresses based from the DUID
slaac private

# Example static IP configuration:
#interface eth0
#static ip_address=192.168.0.10/24
#static ip6_address=fd51:42f8:caae:d92e::ff/64
#static routers=192.168.0.1
#static domain_name_servers=192.168.0.1 8.8.8.8 fd51:42f8:caae:d92e::1

# It is possible to fall back to a static IP if DHCP fails:
# define static profile
#profile static_eth0
#static ip_address=192.168.1.23/24
#static routers=192.168.1.1
#static domain_name_servers=192.168.1.1

# fallback to static profile on eth0
#interface eth0
#fallback static_eth0

interface wlan0
        static ip_address=192.168.4.1/24
        nohook wpa_supplicant
EOF

sudo cat > /etc/sysctl.d/routed-ap.conf << EOF
# Enable IPv4 routing
net.ipv4.ip_forward=1
EOF

sudo iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE

sudo netfilter-persistent save

sudo mv /etc/dnsmasq.conf /etc/dnsmasq.conf.orig
sudo cat > /etc/dnsmasq.conf << EOF
interface=wlan0	# Listening interface
dhcp-range=192.168.4.2,192.168.4.20,255.255.255.0,24h	# Pool of IP addresses via DHCP
domain=wlan	# Local wireless DNS domain
address=/gw.wlan/192.168.4.1	# Alias for this router
EOF

sudo rfkill unblock wlan

sudo cat > /etc/hostapd/hostapd.conf << EOF
country_code=ES
interface=wlan0
ssid=REDBERRYPI
hw_mode=g
channel=7
macaddr_acl=0
auth_algs=1
ignore_broadcast_ssid=0
wpa=2
wpa_passphrase=raspberry
wpa_key_mgmt=WPA-PSK
wpa_pairwise=TKIP
rsn_pairwise=CCMP
EOF

sudo echo "Configuración del punto de acceso finalizada. El sistema se reiniciará en breves segundos..."
sleep 10

sudo systemctl reboot
