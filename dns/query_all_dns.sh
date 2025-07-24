#!/bin/bash

# Default DNS server
DNS_SERVER="192.168.0.207"

# Supported record types
RECORD_TYPES="A AAAA AFSDB APL CAA CDNSKEY CDS CERT CNAME CSYNC DHCID DLV DNAME DNSKEY DS EUI48 EUI64 HINFO HIP HTTPS IPSECKEY KEY KX LOC MX NAPTR NS NSEC NSEC3 NSEC3PARAM OPENPGPKEY PTR RP RRSIG SIG SMIMEA SOA SRV SSHFP SVCB TLSA TXT URI ZONEMD"

# Help function
show_help() {
    echo "Usage: $0 [OPTIONS] DOMAIN"
    echo
    echo "Query all supported DNS record types for the given DOMAIN using dig."
    echo
    echo "Options:"
    echo "  -h, --help           Show this help message and exit"
    echo "  -s, --server IP      Set the DNS server to query (default: $DNS_SERVER)"
    echo
    echo "Example:"
    echo "  $0 example.com"
    echo "  $0 -s 8.8.8.8 example.com"
    exit 1
}

# Parse options
while [[ "$1" == -* ]]; do
    case "$1" in
        -h|--help)
            show_help
            ;;
        -s|--server)
            shift
            if [[ -z "$1" ]]; then
                echo "Error: --server requires an argument."
                show_help
            fi
            DNS_SERVER="$1"
            shift
            ;;
        *)
            echo "Unknown option: $1"
            show_help
            ;;
    esac
done

DOMAIN=$1

# Check if domain is provided
if [[ -z "$DOMAIN" ]]; then
    echo "Error: DOMAIN not specified."
    show_help
fi

for type in $RECORD_TYPES; do
    result=$(dig @"$DNS_SERVER" +short "$DOMAIN" $type)
    if [ ! -z "$result" ]; then
        echo "Records found for $type:"
        echo "$result"
        echo "-----------------------------------"
    fi
done
