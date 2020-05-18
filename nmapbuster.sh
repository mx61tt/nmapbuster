#!/bin/bash

nmapBuster(){

        if [[ ! -d $1 ]]
        then
                mkdir $1
        fi

        echo "NmapBuster v1.0"
        echo "~~~~~~~~~~~~~~~"
        echo ""
        echo "Command:"
        echo "nmap -vv -p- -oA $1/full_port_scan $1"
        echo ""

        nmap -vv -p- -oA $1/full_port_scan $1


        PORTS=$(cat $1/full_port_scan.gnmap | grep -oE '[0-9]{2,5}[/](open|closed|filtered)' | cut -d "/" -f1 | sed -z 's/\n/,/g')
        PORTS_FILTERED=${PORTS::-1}
        
        echo ""
        echo "Initial scan done"
        echo ""
        echo "Command:"
        echo "nmap -vv -A -sC -sV -oA $1/script_version_scan $1 -p $PORTS_FILTERED"
        echo ""

        nmap -vv -A -sC -sV -oA $1/script_version_scan $1 -p $PORTS_FILTERED

        echo ""
        echo "Versions and scripts scan done as well"
}

nmapBuster $1
