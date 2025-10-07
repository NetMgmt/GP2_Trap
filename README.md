# Network Administration - Lab 02
This repository contains all the necessary bits and pieces to work through the
second lab assignment of the Network Administration Course at Universidad de Alcalá.

We leverage [`docker`][docker] and more specifically [`docker-compose`][docker-compose]
to run everything. This means you'll need to [install][docker-installation] it on
your machine before proceeding. This setup will work across operating systems, so you
can run whatever you prefer.

## Starting things up
In order to kickstart the setup simply run

    $ docker-compose up -d

This'll trigger both containers and you're ready to rock!

## Logging into the containers
You can leverage `docker exec` to do so. In this particular case we can open up
a shell in any of the two available containers with

    # Manager
    $ docker exec -it gp2-snmp-manager bash

    # Agent
    $ docker exec -it gp2-snmp-agent bash

That's all really!

### Checking connectivity
The deployment will be set up automatically so that both containers belong to the
same subnet. What's more, `/etc/hosts` will be configured so that one can refer
to the other container by name: it couldn't be more convenient! This basically
means that things work out of the box:

    $ docker exec -it gp2-snmp-manager ping -c 3 agent
    PING agent (172.18.0.2) 56(84) bytes of data.
    64 bytes from agent.gp1_default (172.18.0.2): icmp_seq=1 ttl=64 time=0.174 ms
    64 bytes from agent.gp1_default (172.18.0.2): icmp_seq=2 ttl=64 time=0.097 ms
    64 bytes from agent.gp1_default (172.18.0.2): icmp_seq=3 ttl=64 time=0.205 ms

    --- agent ping statistics ---
    3 packets transmitted, 3 received, 0% packet loss, time 2042ms
    rtt min/avg/max/mdev = 0.097/0.158/0.205/0.045 ms

Using a more suitable example for the matter at hand:

    $ docker exec -it gp2-snmp-manager snmpget -c public -v 1 agent system.sysName.0
    SNMPv2-MIB::sysName.0 = STRING: agent

## Tearing things down
When you're done, simply clean everything up with

    $ docker-compose down

That's it!

<!-- REFs -->
[docker]: https://www.docker.com/
[docker-compose]: https://docs.docker.com/compose/
[docker-installation]: https://docs.docker.com/engine/install/
