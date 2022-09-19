# SPINE Router FRR configuration

```txt
Current configuration:
!
frr version 8.3_git
frr defaults traditional
hostname spine
!
interface eth0
 description Management
exit
!
interface eth1
 description Link to LEAF1
 ipv6 nd ra-interval 10
 no ipv6 nd suppress-ra
exit
!
interface eth2
 description Link to LEAF2
 ipv6 nd ra-interval 10
 no ipv6 nd suppress-ra
exit
!
interface eth3
 description Link to LEAF3
 ipv6 nd ra-interval 10
 no ipv6 nd suppress-ra
exit
!
interface eth4
 description Link to LEAF4
 ipv6 nd ra-interval 10
 no ipv6 nd suppress-ra
exit
!
interface eth5
 description Link to LEAF5
 ipv6 nd ra-interval 10
 no ipv6 nd suppress-ra
exit
!
interface eth6
 description Link to LEAF6
 ipv6 nd ra-interval 10
 no ipv6 nd suppress-ra
exit
!
interface eth7
 description Link to LEAF7
 ipv6 nd ra-interval 10
 no ipv6 nd suppress-ra
exit
!
interface eth8
 description Link to LEAF8
 ipv6 nd ra-interval 10
 no ipv6 nd suppress-ra
exit
!
interface eth9
 description Link to LEAF9
 ipv6 nd ra-interval 10
 no ipv6 nd suppress-ra
exit
!
interface eth10
 description Link to LEAF10
 ipv6 nd ra-interval 10
 no ipv6 nd suppress-ra
exit
!
interface eth11
 description Link to LEAF11
 ipv6 nd ra-interval 10
 no ipv6 nd suppress-ra
exit
!
interface eth12
 description Link to LEAF12
 ipv6 nd ra-interval 10
 no ipv6 nd suppress-ra
exit
!
interface eth13
 description Link to LEAF13
 ipv6 nd ra-interval 10
 no ipv6 nd suppress-ra
exit
!
interface eth14
 description Link to LEAF14
 ipv6 nd ra-interval 10
 no ipv6 nd suppress-ra
exit
!
interface eth15
 description Link to LEAF15
 ipv6 nd ra-interval 10
 no ipv6 nd suppress-ra
exit
!
interface eth16
 description Link to LEAF16
 ipv6 nd ra-interval 10
 no ipv6 nd suppress-ra
exit
!
interface eth17
 description Link to LEAF17
 ipv6 nd ra-interval 10
 no ipv6 nd suppress-ra
exit
!
interface eth18
 description Link to LEAF18
 ipv6 nd ra-interval 10
 no ipv6 nd suppress-ra
exit
!
interface eth19
 description Link to LEAF19
 ipv6 nd ra-interval 10
 no ipv6 nd suppress-ra
exit
!
interface eth20
 description Link to LEAF20
 ipv6 nd ra-interval 10
 no ipv6 nd suppress-ra
exit
!
interface eth21
 description Link to LEAF21
 ipv6 nd ra-interval 10
 no ipv6 nd suppress-ra
exit
!
interface eth22
 description Link to LEAF22
 ipv6 nd ra-interval 10
 no ipv6 nd suppress-ra
exit
!
interface eth23
 description Link to LEAF23
 ipv6 nd ra-interval 10
 no ipv6 nd suppress-ra
exit
!
interface eth24
 description Link to LEAF24
 ipv6 nd ra-interval 10
 no ipv6 nd suppress-ra
exit
!
interface eth25
 description Link to LEAF25
 ipv6 nd ra-interval 10
 no ipv6 nd suppress-ra
exit
!
interface eth26
 description Link to LEAF26
 ipv6 nd ra-interval 10
 no ipv6 nd suppress-ra
exit
!
interface eth27
 description Link to LEAF27
 ipv6 nd ra-interval 10
 no ipv6 nd suppress-ra
exit
!
interface eth28
 description Link to LEAF28
 ipv6 nd ra-interval 10
 no ipv6 nd suppress-ra
exit
!
interface eth29
 description Link to LEAF29
 ipv6 nd ra-interval 10
 no ipv6 nd suppress-ra
exit
!
interface eth30
 description Link to LEAF30
 ipv6 nd ra-interval 10
 no ipv6 nd suppress-ra
exit
!
interface eth31
 description Link to LEAF31
 ipv6 nd ra-interval 10
 no ipv6 nd suppress-ra
exit
!
interface eth32
 description Link to LEAF32
 ipv6 nd ra-interval 10
 no ipv6 nd suppress-ra
exit
!
interface eth33
 description Link to LEAF33
 ipv6 nd ra-interval 10
 no ipv6 nd suppress-ra
exit
!
interface eth34
 description Link to LEAF34
 ipv6 nd ra-interval 10
 no ipv6 nd suppress-ra
exit
!
interface eth35
 description Link to LEAF35
 ipv6 nd ra-interval 10
 no ipv6 nd suppress-ra
exit
!
interface eth36
 description Link to LEAF36
 ipv6 nd ra-interval 10
 no ipv6 nd suppress-ra
exit
!
interface eth37
 description Link to LEAF37
 ipv6 nd ra-interval 10
 no ipv6 nd suppress-ra
exit
!
interface eth38
 description Link to LEAF38
 ipv6 nd ra-interval 10
 no ipv6 nd suppress-ra
exit
!
interface eth39
 description Link to LEAF39
 ipv6 nd ra-interval 10
 no ipv6 nd suppress-ra
exit
!
interface eth40
 description Link to LEAF40
 ipv6 nd ra-interval 10
 no ipv6 nd suppress-ra
exit
!
interface eth41
 description Link to LEAF41
 ipv6 nd ra-interval 10
 no ipv6 nd suppress-ra
exit
!
interface eth42
 description Link to LEAF42
 ipv6 nd ra-interval 10
 no ipv6 nd suppress-ra
exit
!
interface eth43
 description Link to LEAF43
 ipv6 nd ra-interval 10
 no ipv6 nd suppress-ra
exit
!
interface eth44
 description Link to LEAF44
 ipv6 nd ra-interval 10
 no ipv6 nd suppress-ra
exit
!
interface eth45
 description Link to LEAF45
 ipv6 nd ra-interval 10
 no ipv6 nd suppress-ra
exit
!
interface eth46
 description Link to LEAF46
 ipv6 nd ra-interval 10
 no ipv6 nd suppress-ra
exit
!
interface eth47
 description Link to LEAF47
 ipv6 nd ra-interval 10
 no ipv6 nd suppress-ra
exit
!
interface eth48
 description Link to LEAF48
 ipv6 nd ra-interval 10
 no ipv6 nd suppress-ra
exit
!
interface eth49
 description Link to LEAF49
 ipv6 nd ra-interval 10
 no ipv6 nd suppress-ra
exit
!
interface eth50
 description Link to LEAF50
 ipv6 nd ra-interval 10
 no ipv6 nd suppress-ra
exit
!
router bgp 65007
 bgp router-id 10.0.0.1
 bgp log-neighbor-changes
 no bgp ebgp-requires-policy
 no bgp default ipv4-unicast
 bgp bestpath as-path multipath-relax
 timers bgp 3 9
 neighbor LEAF peer-group
 neighbor LEAF remote-as external
 neighbor LEAF capability extended-nexthop
 neighbor eth1 interface peer-group LEAF
 neighbor eth2 interface peer-group LEAF
 neighbor eth3 interface peer-group LEAF
 neighbor eth4 interface peer-group LEAF
 neighbor eth5 interface peer-group LEAF
 neighbor eth6 interface peer-group LEAF
 neighbor eth7 interface peer-group LEAF
 neighbor eth8 interface peer-group LEAF
 neighbor eth9 interface peer-group LEAF
 neighbor eth10 interface peer-group LEAF
 neighbor eth11 interface peer-group LEAF
 neighbor eth12 interface peer-group LEAF
 neighbor eth13 interface peer-group LEAF
 neighbor eth14 interface peer-group LEAF
 neighbor eth15 interface peer-group LEAF
 neighbor eth16 interface peer-group LEAF
 neighbor eth17 interface peer-group LEAF
 neighbor eth18 interface peer-group LEAF
 neighbor eth19 interface peer-group LEAF
 neighbor eth20 interface peer-group LEAF
 neighbor eth21 interface peer-group LEAF
 neighbor eth22 interface peer-group LEAF
 neighbor eth23 interface peer-group LEAF
 neighbor eth24 interface peer-group LEAF
 neighbor eth25 interface peer-group LEAF
 neighbor eth26 interface peer-group LEAF
 neighbor eth27 interface peer-group LEAF
 neighbor eth28 interface peer-group LEAF
 neighbor eth29 interface peer-group LEAF
 neighbor eth30 interface peer-group LEAF
 neighbor eth31 interface peer-group LEAF
 neighbor eth32 interface peer-group LEAF
 neighbor eth33 interface peer-group LEAF
 neighbor eth34 interface peer-group LEAF
 neighbor eth35 interface peer-group LEAF
 neighbor eth36 interface peer-group LEAF
 neighbor eth37 interface peer-group LEAF
 neighbor eth38 interface peer-group LEAF
 neighbor eth39 interface peer-group LEAF
 neighbor eth40 interface peer-group LEAF
 neighbor eth41 interface peer-group LEAF
 neighbor eth42 interface peer-group LEAF
 neighbor eth43 interface peer-group LEAF
 neighbor eth44 interface peer-group LEAF
 neighbor eth45 interface peer-group LEAF
 neighbor eth46 interface peer-group LEAF
 neighbor eth47 interface peer-group LEAF
 neighbor eth48 interface peer-group LEAF
 neighbor eth49 interface peer-group LEAF
 neighbor eth50 interface peer-group LEAF
 !
 address-family ipv4 unicast
  neighbor LEAF activate
 exit-address-family
 !
 address-family ipv6 unicast
  neighbor LEAF activate
 exit-address-family
 !
 address-family l2vpn evpn
  neighbor LEAF activate
 exit-address-family
exit
!
end
```
