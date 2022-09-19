*[HTML]: Hyper Text Markup Language
*[W3C]: World Wide Web Consortium
*[IETF]: Internet Engineering Task Force
*[VLANID]: 802.1q VLAN Identifier
*[VLAN]: Virtual Local Area Network
*[VXLAN]: Virtual eXtensible Local Area Network
*[EVPN]: Address family de BGP para anunciar VPNs ethernet
*[MAC]: Una dirección física del un puerto Ethernet
*[flooding]: "Inundar la red"; Enviar información a a todos los miembros de la red esperando que alguien responda nuestra pregunta
*[frames]: Tramas L2, generalmente Ethernet
*[IPv4]: Protocolo IP, versión 4 (32 bits)
*[IPv6]: Protocolo IP, versión 6 (128 bits)
*[VTEP]: VXLAN Tunnel EndPoint. Es la entidad de red responsable de encapsular y desencapsular tráfico L2. Es el punto de separación entre el underlay y el overlay
*[VNI]: Virtual Network Identifier. Se usa para identificar de forma exclusiva las VXLAN. El VNI es similar a un ID de VLAN, pero tiene 24 bits por lo que su rango de números utilizable es mucho más grande
*[bridge]: Interface virtual que permite forwarding L2 entre sus miembros
*[control plane]: Plano de control de un dispositivo de red, que permite aprender información acerca de cómo reenviar tráfico hacia otros dispositivos
*[unicast]: Es un método de transmitir información de manera unidireccional hacia un único receptor
*[multicast]: Es un método para transmitir información de manera unidireccional hacia un grupo de receptores que están unidos a dicho grupo
*[Multicast]: Es un método para transmitir información de manera unidireccional hacia un grupo de receptores que están unidos a dicho grupo
*[underlay]: Es la red tradicional que sirve de base para transportar paquetes de extremo a extremo. Incluye: enlaces, transporte L2 o protocolos de ruteo
*[overlay]: Es una red virtual que se crea por encima de una red underlay. Algunos ejemplos de overlay son las redes virtuales generados con VPLS o VXLAN
*[eth0]: Interface de red de un equipo llamada eth0 (en este lab se usa para gestión)
*[eth1]: Interface de red de un equipo llamada eth1
*[eth2]: Interface de red de un equipo llamada eth2
*[eth3]: Interface de red de un equipo llamada eth3
*[eth4]: Interface de red de un equipo llamada eth4
*[BGP]: Border Gateway Protocol es el protocolo que hace que los routers puedan interconectar distintos Sistemas Autónomos, permitiendo que Internet funcione
*[AFI]: Address Family Indicator de BGP, indica a qué familia de direcciones pertenecen las rutas aprendidas (IPv4, IPv6, L3VPN, L2VPN, FloswSpec, etc)
*[SAFI]: Subsequent Address Family Indicator de BGP, indica qué sub-familia de direcciones pertenecen las rutas aprendidas (Unicast, Multicast, MPLS Label, EVPN, etc)
*[NLRI]: Network Layer Reachability Information, son mensajes de BGP que se intercambian entre los peers y que proveen información de cómo alcanzar ciertos recursos
*[FRRouting]: FRRouting (FRR) es un software para usar protocolos de enrutamiento de Internet, es gratuito y de código abierto para plataformas Linux y Unix. Implementa BGP, OSPF, RIP, IS-IS, PIM, LDP, BFD, Babel, PBR, OpenFabric y VRRP, con soporte alfa para EIGRP y NHRP
*[FRR]: FRRouting (FRR) es un software para usar protocolos de enrutamiento de Internet, es gratuito y de código abierto para plataformas Linux y Unix. Implementa BGP, OSPF, RIP, IS-IS, PIM, LDP, BFD, Babel, PBR, OpenFabric y VRRP, con soporte alfa para EIGRP y NHRP