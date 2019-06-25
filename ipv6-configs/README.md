# ipv6-configs README
This directory contains the final configurations from the
presentation except the entire network has been outfitted
with dual-stack IPv4/IPv6. OSPFv2 is still used for IPv4
and OSPFv3 has been added to support IPv6.

## IPv6 Addressing
All routers have link-local addresses in the format `FE80::X/64`
where `X` is the router number in decimal. Likewise, each
router has a loopback address in the format `FC00::X/128` where `X`
remains the router number in decimal.

Some links required unique-local addressing. Those are in
the format `FC00:10:X:Y::Z/64` where `X` and `Y` are the router
numbers on the link. `Z` is the router number of the specific host.
Again, all numbers are in decimal to keep it simple.

## Routing asymmetry
R4 cannot download R1's startup configuring using the alias `dl6`.
Use the graph tracing skills learned in the video to find and fix the problem.
Since you've seen the session, you already know the problem, so be sure to
increase R1's Ethernet0/1 cost to replicate the fault.

```
R4#dl6
Accessing http://*:*@[fc00::1]/startup-config.cfg...
%Error opening http://*:*@[fc00::1]/startup-config.cfg (I/O error)
```

__Coming soon__: I will be posting a supplementary video on Youtube
to walk through the graph tracing process for OSPFv3. Stay tuned!
