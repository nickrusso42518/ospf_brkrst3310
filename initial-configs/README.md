# initial-configs README
This file contains bug-riddles files for your troubleshooting pleasure.
The subsections below summarize the problems. Please review the official
Cisco Live BRKRST-3310 presentation and video for detailed
solutions/explanations. The hyperlink is in the top-level README.

## Routing asymmetry
R4 cannot download R1's startup configuring using the alias `dl`.
Use the graph tracing skills learned in the session to find and fix the problem.

```
R4#dl
Accessing http://*:*@10.0.0.1/startup-config.cfg...
%Error opening http://*:*@10.0.0.1/startup-config.cfg (I/O error)
```

## Adjacency problems
There are 5 routers and 4 links in area 1. Each link has 3 to 4
misconfigurations that need to be resolved. Once complete, all 4
adjacencies should be up and area 1 routers should have
reachability between one another.

> Most of these issues were not included in the discussion but are
included in the PDF. Their simple nature makes them inappropriate
for an advanced 3000-series breakout.

## Virtual link problems
Once the area 1 links are fixed, a virtual link between R4 and R11
is not coming up. This virtual link connects two discontiguous area 0
parts of the network together.

```
R4#show ip ospf virtual-links | include is down
Virtual Link OSPF_VL0 to router 10.0.0.11 is down

R11#show ip ospf virtual-links | include is down
Virtual Link OSPF_VL0 to router 10.0.0.4 is down
```

## Forward address reachability
Routers outside of area 2 cannot reach `10.0.0.17`.

```
R3#ping 10.0.0.17 source loopback0
Type escape sequence to abort.
Sending 5, 100-byte ICMP Echos to 10.0.0.17, timeout is 2 seconds:
Packet sent with a source address of 10.0.0.3
!!!!!
Success rate is 100 percent (5/5), round-trip min/avg/max = 1/2/5 ms

R2#ping 10.0.0.17 source loopback0
Type escape sequence to abort.
Sending 5, 100-byte ICMP Echos to 10.0.0.17, timeout is 2 seconds:
Packet sent with a source address of 10.0.0.2
.....
Success rate is 0 percent (0/5)
```

## Suboptimal routing problems
The link between R1 and R12 is down for maintenance and routing
reachability from R12 to `10.0.0.1` and `10.3.3.1` seems suboptimal.
See traceroutes below. Ensure that the solution keeps both routing
paths limited to 2 hops.

```
R12#traceroute 10.3.3.1
Type escape sequence to abort.
Tracing the route to 10.3.3.1
VRF info: (vrf in name/id, vrf out name/id)
  1 10.12.14.14 1 msec 0 msec 0 msec
  2 10.13.14.13 0 msec 0 msec 1 msec
  3 10.1.13.1 0 msec 1 msec 1 msec

R12#traceroute 10.0.0.1
Type escape sequence to abort.
Tracing the route to 10.0.0.1
VRF info: (vrf in name/id, vrf out name/id)
  1 10.12.14.14 1 msec 0 msec 0 msec
  2 10.1.14.1 0 msec 0 msec 1 msec
```

Once you have finished all these issues, feel free to explore with
area 4 (NSSA), OSPF over hub/spoke networks, and other interesting parts
of the network. Last, note that a 20th device was not included intentionally.
You may add another device anywhere in the network where you think it would
be fun. This includes other devices like Cisco ASAv, Cisco NX-OSv,
Cisco IOS-XRv, or third-party virtual network instances.
