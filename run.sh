#!/bin/bash

source .env

NEW_IP="$1/32"  # Use the passed IP address

# Fetch the current firewall details
firewall_details=$(curl -s -H "Authorization: Bearer $API_TOKEN" "https://api.hetzner.cloud/v1/firewalls/$FIREWALL_ID")

# Extract existing rules, remove the rule with the specified port 8443
existing_rules=$(echo "$firewall_details" | jq '.firewall.rules')
filtered_rules=$(echo "$existing_rules" | jq 'map(select(.port != "8443" and .port != "22" and .protocol != "tcp"))')

# Prepare the data for the PUT request to remove the old rule
update_data=$(jq -n --argjson rules "$filtered_rules" '{rules: $rules}')

# Update the firewall to remove the old rule
curl -X PUT -H "Authorization: Bearer $API_TOKEN" -H "Content-Type: application/json" -d "$update_data" "https://api.hetzner.cloud/v1/firewalls/$FIREWALL_ID"

# Create the new rule with the updated IP address for port 8443
new_rule_8443=$(jq -n --arg port "8443" --arg ip "$NEW_IP" '{"direction": "in", "protocol": "tcp", "port": $port, "source_ips": [$ip], "destination_ips": []}')

# Create rules for all IPv4 and IPv6 on ports 80 and 443
rules_ports_80_443=()
for port in 80 443; do
    rule_ipv4=$(jq -n --arg port "$port" --arg ip "0.0.0.0/0" '{"direction": "in", "protocol": "tcp", "port": $port, "source_ips": [$ip], "destination_ips": []}')
    rule_ipv6=$(jq -n --arg port "$port" --arg ip "::/0" '{"direction": "in", "protocol": "tcp", "port": $port, "source_ips": [$ip], "destination_ips": []}')
    rules_ports_80_443+=("$rule_ipv4")
    rules_ports_80_443+=("$rule_ipv6")
done

# Create the new rule for port 22 with the updated IP address
new_rule_22=$(jq -n --arg port "22" --arg ip "$NEW_IP" '{"direction": "in", "protocol": "tcp", "port": $port, "source_ips": [$ip], "destination_ips": []}')

# Combine all the new rules
all_new_rules=$(jq -n --argjson rule1 "$new_rule_8443" --argjson rule2 "$new_rule_22" --argjson rule3 "$(echo "${rules_ports_80_443[@]}" | jq -s '.')" '$rule3 + [$rule1, $rule2]')

# Prepare the final data for setting the new rules
final_data=$(jq -n --argjson rules "$all_new_rules" '{rules: $rules}')

# Set the new rules in the firewall
curl -X POST -H "Authorization: Bearer $API_TOKEN" -H "Content-Type: application/json" -d "$final_data" "https://api.hetzner.cloud/v1/firewalls/$FIREWALL_ID/actions/set_rules"
