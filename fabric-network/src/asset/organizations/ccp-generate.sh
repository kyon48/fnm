#!/bin/bash

function one_line_pem {
    echo "`awk 'NF {sub(/\\n/, ""); printf "%s\\\\\\\n",$0;}' $1`"
}

function json_ccp {
    local PP=$(one_line_pem $4)
    local CP=$(one_line_pem $5)
    sed -e "s/\${ORG}/$1/" \
        -e "s/\${P0PORT}/$2/" \
        -e "s/\${CAPORT}/$3/" \
        -e "s#\${PEERPEM}#$PP#" \
        -e "s#\${CAPEM}#$CP#" \
        src/asset/organizations/ccp-template.json
}

function yaml_ccp {
    local PP=$(one_line_pem $4)
    local CP=$(one_line_pem $5)
    sed -e "s/\${ORG}/$1/" \
        -e "s/\${P0PORT}/$2/" \
        -e "s/\${CAPORT}/$3/" \
        -e "s#\${PEERPEM}#$PP#" \
        -e "s#\${CAPEM}#$CP#" \
        src/asset/organizations/ccp-template.yaml | sed -e $'s/\\\\n/\\\n          /g'
}

ORG=1
P0PORT=7051
CAPORT=7054
PEERPEM=src/asset/organizations/peerOrganizations/org1.islab.re.kr/tlsca/tlsca.org1.islab.re.kr-cert.pem
CAPEM=src/asset/organizations/peerOrganizations/org1.islab.re.kr/ca/ca.org1.islab.re.kr-cert.pem

echo "$(json_ccp $ORG $P0PORT $CAPORT $PEERPEM $CAPEM)" > src/asset/organizations/peerOrganizations/org1.islab.re.kr/connection-org1.json
echo "$(yaml_ccp $ORG $P0PORT $CAPORT $PEERPEM $CAPEM)" > src/asset/organizations/peerOrganizations/org1.islab.re.kr/connection-org1.yaml

ORG=2
P0PORT=9051
CAPORT=8054
PEERPEM=src/asset/organizations/peerOrganizations/org2.islab.re.kr/tlsca/tlsca.org2.islab.re.kr-cert.pem
CAPEM=src/asset/organizations/peerOrganizations/org2.islab.re.kr/ca/ca.org2.islab.re.kr-cert.pem

echo "$(json_ccp $ORG $P0PORT $CAPORT $PEERPEM $CAPEM)" > src/asset/organizations/peerOrganizations/org2.islab.re.kr/connection-org2.json
echo "$(yaml_ccp $ORG $P0PORT $CAPORT $PEERPEM $CAPEM)" > src/asset/organizations/peerOrganizations/org2.islab.re.kr/connection-org2.yaml
