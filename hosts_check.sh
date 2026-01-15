verificare_ip() {
	local name= "$1"
	local ip="$2"
	local dns_server="$3"

	dns_ip=$(nslookup "$name" "dns_server" 2>/dev/null \
		| awk '/Address: / {print $2; exit}')

	if [ -n "$dns_ip"]; then
		if [ "dns_ip" != "$ip" ]; then
			echo "Bogus IP for $name in /etc/hosts!"
		fi
	fi
}

DNS_SERVER="8.8.8.8"

cat /etc/hosts | while read ip name; do
	[ -z "$name" ] && continue
	verificare_ip "$name" "$ip" "$DNS_SERVER"
done
