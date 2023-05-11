#!/bin/bash

function network_start {
    sudo cp -rf ./chaincode ./fabric-network/src/asset
    sudo bash ./fabric-network/network.sh up createChannel -ca
    sudo bash ./fabric-network/network.sh deployCC -ccn basic -ccp ./src/asset/chaincode -ccl go
}

function network_clear {
    sudo bash ./fabric-network/network.sh down
    sudo rm -rf ./fabric-network/src/asset/chaincode
    sudo rm -rf ./fabric-network/src/asset/channel-artifacts
}

# function network_invoke {
#     CHANNEL=$1
#     CHAINCODE_NAME=$2
#     sudo bash ./blockchain/blockchain.sh invoke $CHANNEL $CHAINCODE_NAME
# }

# function network_query {
#     CHANNEL=$1
#     CHAINCODE_NAME=$2
#     sudo bash ./blockchain/blockchain.sh query $CHANNEL $CHAINCODE_NAME
# }

# function network_clear {
#     docker rm -f -v `docker ps -aqf "name=ca.btp.islab.re.kr"`
#     docker rm -f -v `docker ps -aqf "name=cli.peer0.btp.islab.re.kr"`
#     docker rm -f -v `docker ps -aqf "name=couchdb.peer0.btp.islab.re.kr"`
#     docker rm -f -v `docker ps -aqf "name=btp-peer0.btp.islab.re.kr/*"`
#     docker rm -f -v `docker ps -aqf "name=orderer0.islab.re.kr"`
#     docker rm -f -v `docker ps -aqf "name=peer0.btp.islab.re.kr"`
#     sleep 3s
#     sudo bash ./blockchain/blockchain.sh clean
# }

# function network_restart {
#     network_clear
#     sleep 1s
#     network_start
# }

function network_usage {
    echo "RED" "you should use start | clear | invoke | query | restart"
}

function main {
    case $1 in
        start | clear)
            cmd=network_$1
            shift
            $cmd $@
            ;;
        *)
            network_usage
            exit
            ;;
    esac
}

main $@