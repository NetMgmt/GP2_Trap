#!/bin/bash

# /etc/hosts
chmod a+r /etc/hosts

# Update SNMP config /cat-touch
apt-get update
apt-get -y install snmp-mibs-downloader
download-mibs

# How to fix net-snmp 
wget -q https://www.iana.org/assignments/ianastoragemediatype-mib/ianastoragemediatype-mib -O /usr/share/snmp/mibs/iana/IANA-STORAGE-MEDIA-TYPE-MIB
wget -q https://www.iana.org/assignments/ianasmf-mib/ianasmf-mib -O /usr/share/snmp/mibs/iana/IANA-SMF-MIB
wget -q https://www.iana.org/assignments/ianaentity-mib/ianaentity-mib -O /usr/share/snmp/mibs/iana/IANA-ENTITY-MIB
wget -q https://www.iana.org/assignments/ianapowerstateset-mib/ianapowerstateset-mib -O /usr/share/snmp/mibs/iana/IANAPowerStateSet-MIB 
wget -q https://www.iana.org/assignments/ianabfdtcstd-mib/ianabfdtcstd-mib -O /usr/share/snmp/mibs/iana/IANA-BFD-TC-STD-MIB 
wget -q https://www.iana.org/assignments/ianaolsrv2linkmetrictype-mib/ianaolsrv2linkmetrictype-mib -O /usr/share/snmp/mibs/iana/IANA-OLSRv2-LINK-METRIC-TYPE-MIB 
wget -q https://www.iana.org/assignments/ianaenergyrelation-mib/ianaenergyrelation-mib -O /usr/share/snmp/mibs/iana/IANA-ENERGY-RELATION-MIB
wget -q https://www.ieee802.org/1/files/public/MIBs/LLDP-MIB-200505060000Z.mib -O /usr/share/snmp/mibs/ietf/LLDP-MIB
wget -q https://www.ieee802.org/1/files/public/MIBs/IEEE8021-CFM-MIB-200810150000Z.mib -O /usr/share/snmp/mibs/ietf/IEEE8021-CFM-MIB

# Se arranca SNMP-net 5.9.4 que ya incluye SNMPv2-PDU por eso se elimiba del share descargado
rm -f /usr/share/snmp/mibs/ietf/SNMPv2-PDU

#2420 MIB parser fails to parse value definition - https://sourceforge.net/p/net-snmp/bugs/2420/
#cat > /usr/share/mibs/ietf/SNMPv2-PDU <<EOD
#...
#EOD
#rm /usr/share/mibs/ietf/IPATM/IPMC-MIB
#rm /usr/share/mibs/iana/IANA-IPPM-METRICS-REGISTRY-MIB

# Unzip the auxiliar data
unzip /gpx/gp2.zip
rm /gpx/gp2.zip 
chmod 555 /gpx/gp2/*.sh

# To have the new MIBs recognized by net-snmp
cat > /etc/snmp/snmp.conf <<EOD
mibs +ALL
EOD


