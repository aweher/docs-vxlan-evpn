# CheatSheet

```bash
# Create a bridge
ip link add name bridge_name type bridge
ip link set bridge_name up

# Add an interface to the bridge (state must be up)
ip link set eth0 up
ip link set eth0 master bridge_name

# Remove an interface from a bridge
ip link set eth0 nomaster

# Remove bridge
ip link delete bridge_name type bridge

# Show existing bridges and associated interfaces
bridge link

# Show MAC addresses from a bridge
bridge fdb

# Capture traffic from containerlab to wireshark (local)
sudo ip netns exec docker_container_name tcpdump -U -nn -i the_interface -w - | wireshark -k -i -

# Capture traffic from containerlab to wireshark (remote)
ssh vxlan.nog.lat "ip netns exec docker_container_name tcpdump -U -nn -i the_interface -w - " | wireshark -k -i -
```
