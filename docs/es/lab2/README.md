# Laboratorio 2: VXLAN con EVPN

En esta práctica, vamos a configurar un servicio VXLAN en donde toda la información de los VTEP y equipos conectados a las VNI se intercambia mediante un control plane basado en el protocolo EVPN, que permite intercambiar distintos tipos de NLRI.

Todos los equipos están interconectados en su interface eth1 hacia SPINE1 y en su interface eth2 hacia SPINE2.

SPINE1 y SPINE2 están configurados para establecer peers de BGP en todas sus interfaces desde el sistema autónomo 65007.

![Laboratorio2](../../assets/vxlan-evpn.svg)

Para completar este ejercicio, se debe levantar una sesión de BGP multifamilia desde cada LEAF hacia SPINE1 y SPINE2, al activar el soporte de EVPN, se podrán conocer todas las MAC de cada HOST mediante la publicación de estos datos junto con los VNI por cada sesión BGP.

Hay dos tipos básicos de información de alcanzabilidad que un VTEP envía a través de BGP EVPN

* La información de cómo manegar el tráfico BUM de un determinado VNI (como rutas de tipo 3).
* Por cada VNI, las direcciones MAC locales (como rutas de tipo 2).

??? error "Conectar al Laboratorio"

    <a href="https://ssh.nog.lat/?hostname=access.nog.lat&username=lablacnog&password=UmFkaWFQZXJsbWFuCg==" target="_blank">Click para abrir el laboratorio en una nueva pestaña 😉</a>

    Desconectar de un equipo y volver al menú principal: ++ctrl+d++

## Actividad 2.1

??? example "Actividad 2.1.1"

    En LEAF[X] vamos a generar una interface bridge101 que va a incluír como miembro a la ether3 (link hacia HOST[X]).

    === "LEAF[X]"

        ```txt hl_lines="6"
            / # ip link add name bridge101 type bridge
            / # ip link set eth3 up
            / # ip link set bridge101 up
            / # ip link set eth3 master bridge101
            / # bridge link
            4812: eth3@if4811: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 9500 master bridge101 state forwarding priority 32 cost 2
        ```

    Antes de generar la interface VXLAN, debemos asignar una dirección IPv4 o IPv6 al LEAF[X] de manera tal que sea utilizada como VTEP y anunciada por BGP al resto de la red. Este VTEP debe ser alcanzable por todos los participantes para que finalmente se puedan generar túneles VXLAN de manera dinámica cuando EVPN distribuya toda la información de alcanzabilidad entre todos los routers.

    === "LEAF[X]"

        ```txt hl_lines="7"
            / # ip -6 address add 2001:db8:beef::[X]/128 dev lo
            / # ip a show dev lo
            1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
                link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
                inet 127.0.0.1/8 scope host lo
                valid_lft forever preferred_lft forever
                inet 100.100.100.[X]/32 scope global lo
                valid_lft forever preferred_lft forever
                inet6 ::1/128 scope host 
                valid_lft forever preferred_lft forever
        ```

??? example "Actividad 2.1.2"

    Ahora en LEAF[X], vamos a generar una interface VXLAN con VNI = 101 indicando que la dirección del VTEP local es la recientemente creada.
    Luego crearemos un bridge para conectar la `vxlan101` con la eth3.

    === "LEAF[X]"

        ```txt hl_lines="4 10 16"
            / # ip link add vxlan101 mtu 9000 type vxlan id 101 local 2001:db8:beef::[X] dstport 4789 nolearning
            / # ip link set vxlan101 up

            / # vtysh -c "show interface vxlan101"
                Interface vxlan101 is up, line protocol is up
                Link ups:       1    last: 2022/09/13 23:04:22.73
                Link downs:     0    last: (never)
                vrf: default
                index 4 metric 0 mtu 9000 speed 0 
                flags: <UP,BROADCAST,RUNNING,MULTICAST>
                Type: Ethernet
                HWaddr: 26:8d:4d:86:5e:c1
                inet6 fe80::248d:4dff:fe86:5ec1/64
                Interface Type Vxlan
                Interface Slave Type None
                VxLAN Id 101
                protodown: off 
        ```

??? example "Actividad 2.1.3"

    En LEAF[X], agregamos la interface `vxlan101` al bridge `bridge101`.

    === "LEAF[X]"

        ```txt hl_lines="3 4"
            / # ip link set vxlan101 master bridge101
            / # bridge link
            282: eth3@if281: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 9500 master bridge101 state forwarding priority 32 cost 2 
            4: vxlan101: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 9000 master bridge101 state forwarding priority 32 cost 100 
        ```

??? example "Actividad 2.1.4"

    En LEAF[X], configuramos las sesiones de BGP sobre las interfaces eth1 y eth2 utilizando RFC8950 en el software FRRouting.

    !!! info "Importante"
        Ingresar a la configuración de FRRouting ejecutando el comando `vtysh`.

    === "LEAF[X] (en vtysh)"

        ```txt
            configure terminal
            
            router bgp [X]
             bgp router-id 100.100.100.[X]
             bgp log-neighbor-changes
             bgp default show-nexthop-hostname
             no bgp ebgp-requires-policy
             no bgp default ipv4-unicast
             bgp bestpath as-path multipath-relax
             timers bgp 3 9
             neighbor SPINE peer-group
             ! por favor no modificar el valor 65007 del próximo comando...
             neighbor SPINE remote-as 65007
             !
             neighbor SPINE capability extended-nexthop
             neighbor eth1 interface peer-group SPINE
             neighbor eth1 description SPINE1
             neighbor eth2 interface peer-group SPINE
             neighbor eth2 description SPINE2
             !
             address-family ipv6 unicast
              maximum-paths 64
              neighbor SPINE activate
              redistribute connected
             exit-address-family
            !
             address-family l2vpn evpn
              neighbor SPINE activate
              advertise-all-vni
             exit-address-family
            end

            write
        ```

??? example "Actividad 2.1.5"

    En LEAF[X], chequeamos que se establezcan correctamente los peers contra SPINE1 y SPINE2 en las 3 address-family (IPv4, IPv6, L2VPN EVPN).

    === "LEAF[X] (en vtysh)"

        ```txt hl_lines="3 11 12 17 25 26 31 39 40"
        leaf[X]# show bgp sum established 

        IPv6 Unicast Summary (VRF default):
        BGP router identifier 100.100.100.[X], local AS number [X] vrf-id 0
        BGP table version 2
        RIB entries 3, using 576 bytes of memory
        Peers 2, using 1433 KiB of memory
        Peer groups 1, using 64 bytes of memory

        Neighbor        V         AS   MsgRcvd   MsgSent   TblVer  InQ OutQ  Up/Down State/PfxRcd   PfxSnt Desc
        eth1            4      65007       109       111        0    0    0 00:05:11            0        2 SPINE1
        eth2            4      65007       109       111        0    0    0 00:05:11            0        2 SPINE2

        Displayed neighbors 2
        Total number of neighbors 2

        L2VPN EVPN Summary (VRF default):
        BGP router identifier 100.100.100.[X], local AS number [X] vrf-id 0
        BGP table version 0
        RIB entries 1, using 192 bytes of memory
        Peers 2, using 1433 KiB of memory
        Peer groups 1, using 64 bytes of memory

        Neighbor        V         AS   MsgRcvd   MsgSent   TblVer  InQ OutQ  Up/Down State/PfxRcd   PfxSnt Desc
        eth1            4      65007       109       111        0    0    0 00:05:11            0        1 SPINE1
        eth2            4      65007       109       111        0    0    0 00:05:11            0        1 SPINE2

        Displayed neighbors 2
        Total number of neighbors 2
        ```

??? example "Actividad 2.1.6"

    En LEAF[X], chequeamos que se reciba información de NLRI en IPv6 y L2VPN EVPN.

    === "LEAF[X] (en vtysh) - MAC recibidas por VNI"

        ```txt hl_lines="2 5"
        leaf[X]# show evpn mac vni 101
        Number of MACs (local and remote) known for this VNI: 2
        Flags: N=sync-neighs, I=local-inactive, P=peer-active, X=peer-proxy
        MAC               Type   Flags Intf/Remote ES/VTEP            VLAN  Seq #'s
        aa:c1:ab:e6:99:af remote       100.100.100.[Y]                      0/0
        aa:c1:ab:93:63:02 local        eth3                                 0/0
        ```

    === "LEAF[X] (en vtysh) - NLRI Recibido por BGP EVPN"

        ```txt hl_lines="21 24 34"
        leaf[X]# show bgp l2vpn evpn route
        BGP table version is 1, local router ID is 100.100.100.[X]
        Status codes: s suppressed, d damped, h history, * valid, > best, i - internal
        Origin codes: i - IGP, e - EGP, ? - incomplete
        EVPN type-1 prefix: [1]:[EthTag]:[ESI]:[IPlen]:[VTEP-IP]:[Frag-id]
        EVPN type-2 prefix: [2]:[EthTag]:[MAClen]:[MAC]:[IPlen]:[IP]
        EVPN type-3 prefix: [3]:[EthTag]:[IPlen]:[OrigIP]
        EVPN type-4 prefix: [4]:[ESI]:[IPlen]:[OrigIP]
        EVPN type-5 prefix: [5]:[EthTag]:[IPlen]:[IP]

        Network          Next Hop            Metric LocPrf Weight Path
                            Extended Community
        Route Distinguisher: 100.100.100.[Y]:2
        *  [3]:[0]:[32]:[100.100.100.[Y]]
                            100.100.100.[Y]                          0 65007 [Y] i
                            RT:[Y]:101 ET:8
        *> [3]:[0]:[32]:[100.100.100.[Y]]
                            100.100.100.[Y]                          0 65007 [Y] i
                            RT:[Y]:101 ET:8
        Route Distinguisher: 100.100.100.[Y]:2
        *  [2]:[0]:[48]:[aa:c1:ab:e6:99:af]
                            100.100.100.[Y]                          0 65007 [Y] i
                            RT:[Y]:101 ET:8
        *> [2]:[0]:[48]:[aa:c1:ab:e6:99:af]
                            100.100.100.[Y]                          0 65007 [Y] i
                            RT:[Y]:101 ET:8
        *  [3]:[0]:[32]:[100.100.100.[Y]]
                            100.100.100.[Y]                          0 65007 [Y] i
                            RT:[Y]:101 ET:8
        *> [3]:[0]:[32]:[100.100.100.[Y]]
                            100.100.100.[Y]                          0 65007 [Y] i
                            RT:[Y]:101 ET:8
        Route Distinguisher: 100.100.100.[X]:2
        *> [2]:[0]:[48]:[aa:c1:ab:93:63:02]
                            100.100.100.[X]                     32768 i
                            ET:8 RT:[X]:101
        *> [3]:[0]:[32]:[100.100.100.[X]]
                            100.100.100.[X]                     32768 i
                            ET:8 RT:[X]:101

        Displayed 5 prefixes (8 paths)
        ```

??? example "Actividad 2.1.7"

    En HOST[X], chequeamos conectividad L2 los otros hosts.

    === "HOST[X] - PING a otro HOST"

        ```txt hl_lines="2 14-16"
        / # ping -c 10 -s 2000 -M dont 10.0.0.[Y]
        PING 10.0.0.[Y] (10.0.0.[Y]) 2000(2028) bytes of data.
        2008 bytes from 10.0.0.[Y]: icmp_seq=1 ttl=64 time=0.159 ms
        2008 bytes from 10.0.0.[Y]: icmp_seq=2 ttl=64 time=0.090 ms
        2008 bytes from 10.0.0.[Y]: icmp_seq=3 ttl=64 time=0.089 ms
        2008 bytes from 10.0.0.[Y]: icmp_seq=4 ttl=64 time=0.097 ms
        2008 bytes from 10.0.0.[Y]: icmp_seq=5 ttl=64 time=0.086 ms
        2008 bytes from 10.0.0.[Y]: icmp_seq=6 ttl=64 time=0.042 ms
        2008 bytes from 10.0.0.[Y]: icmp_seq=7 ttl=64 time=0.083 ms
        2008 bytes from 10.0.0.[Y]: icmp_seq=8 ttl=64 time=0.088 ms
        2008 bytes from 10.0.0.[Y]: icmp_seq=9 ttl=64 time=0.079 ms
        2008 bytes from 10.0.0.[Y]: icmp_seq=10 ttl=64 time=0.089 ms

        --- 10.0.0.[Y] ping statistics ---
        10 packets transmitted, 10 received, 0% packet loss, time 9202ms
        rtt min/avg/max/mdev = 0.042/0.090/0.159/0.027 ms
        ```

    === "HOST[X] - Tabla de ARP"

        ```txt hl_lines="2"
        / # arp -an
        ? (10.0.0.[Y]) at aa:c1:ab:93:63:02 [ether] on eth1
        ```

    === "HOST[X] - Prueba de NMAP"

        ```txt hl_lines="25"
        / # nmap -A 10.0.0.[Y]
        Starting Nmap 7.92 ( https://nmap.org ) at 2022-09-14 00:46 UTC
        Nmap scan report for 10.0.0.[Y]
        Host is up (0.000053s latency).
        Not shown: 998 closed tcp ports (reset)
        PORT    STATE SERVICE  VERSION
        80/tcp  open  http     nginx 1.20.2
        |_http-server-header: nginx/1.20.2
        |_http-title: Site doesn't have a title (text/html).
        443/tcp open  ssl/http nginx 1.20.2
        | ssl-cert: Subject: commonName=localhost
        | Not valid before: 2021-12-20T10:48:38
        |_Not valid after:  2031-12-18T10:48:38
        | tls-alpn: 
        |_  http/1.1
        |_ssl-date: TLS randomness does not represent time
        |_http-server-header: nginx/1.20.2
        | tls-nextprotoneg: 
        |_  http/1.1
        |_http-title: Site doesn't have a title (text/html).
        MAC Address: AA:C1:AB:93:63:02 (Unknown)
        
        [...]

        Network Distance: 1 hop

        TRACEROUTE
        HOP RTT     ADDRESS
        1   0.05 ms 10.0.0.[Y]

        OS and Service detection performed. Please report any incorrect results at https://nmap.org/submit/ .
        Nmap done: 1 IP address (1 host up) scanned in 35.46 seconds
        ```

    === "HOST[X] - TracePath con MTU alto"

        ```txt hl_lines="2 3"
        / # tracepath -4 -l 9000 -n 10.0.0.[Y]
        1:  10.0.0.[Y]                                             0.119ms reached
            Resume: pmtu 9000 hops 1 back 1 
        ```
