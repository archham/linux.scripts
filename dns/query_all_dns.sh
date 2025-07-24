#!/bin/bash

DOMAIN=$1
RECORD_TYPES="A AAAA AFSDB APL CAA CDNSKEY CDS CERT CNAME CSYNC DHCID DLV DNAME DNSKEY DS EUI48 EUI64 HINFO HIP HTTPS IPSECKEY KEY KX LOC MX NAPTR NS NSEC NSEC3 NSEC3PARAM OPENPGPKEY PTR RP RRSIG SIG SMIMEA SOA SRV SSHFP SVCB TLSA TXT URI ZONEMD"

for type in $RECORD_TYPES; do
    result=$(dig @192.168.0.207 +short $DOMAIN $type)
    if [ ! -z "$result" ]; then
        echo "Records found for $type:"
        echo "$result"
        echo "-----------------------------------"
    fi
done

