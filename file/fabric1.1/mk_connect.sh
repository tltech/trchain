composer card delete -c PeerAdmin@byfn-network-org1
composer card delete -c PeerAdmin@byfn-network-org2
composer card delete -c PeerAdmin@byfn-network-org3
rm -fr $HOME/.composer
#rm -rf /tmp/composer
mkdir -p /tmp/composer/org1

mkdir -p /tmp/composer/org2

mkdir -p /tmp/composer/org3

export ORG1=crypto-config/peerOrganizations/org1.example.com/users/Admin@org1.example.com/msp

cp -p $ORG1/signcerts/A*.pem /tmp/composer/org1

cp -p $ORG1/keystore/*_sk /tmp/composer/org1
export ORG2=crypto-config/peerOrganizations/org2.example.com/users/Admin@org2.example.com/msp

cp -p $ORG2/signcerts/A*.pem /tmp/composer/org2

cp -p $ORG2/keystore/*_sk /tmp/composer/org2
export ORG3=crypto-config/peerOrganizations/org3.example.com/users/Admin@org3.example.com/msp

cp -p $ORG3/signcerts/A*.pem /tmp/composer/org3

cp -p $ORG3/keystore/*_sk /tmp/composer/org3


awk 'NF {sub(/\r/, ""); printf "%s\\n",$0;}' crypto-config/peerOrganizations/org1.example.com/peers/peer0.org1.example.com/tls/ca.crt > /tmp/composer/org1/ca-org1.txt
awk 'NF {sub(/\r/, ""); printf "%s\\n",$0;}' crypto-config/peerOrganizations/org3.example.com/peers/peer0.org3.example.com/tls/ca.crt > /tmp/composer/org3/ca-org3.txt

awk 'NF {sub(/\r/, ""); printf "%s\\n",$0;}' crypto-config/peerOrganizations/org2.example.com/peers/peer0.org2.example.com/tls/ca.crt > /tmp/composer/org2/ca-org2.txt
awk 'NF {sub(/\r/, ""); printf "%s\\n",$0;}' crypto-config/ordererOrganizations/example.com/orderers/orderer.example.com/tls/ca.crt > /tmp/composer/ca-orderer.txt
org1=`cat /tmp/composer/org1/ca-org1.txt`
org2=`cat /tmp/composer/org2/ca-org2.txt`
org3=`cat /tmp/composer/org3/ca-org3.txt`

ord=`cat /tmp/composer/ca-orderer.txt`
cat >/tmp/composer/byfn-network.json<<EOF
{
    "name": "byfn-network",
    "x-type": "hlfv1",
    "version": "1.0.0",
    "channels": {
        "mychannel": {
            "orderers": [
                "orderer.example.com"
            ],
            "peers": {
                "peer0.org1.example.com": {
                    "endorsingPeer": true,
                    "chaincodeQuery": true,
                    "eventSource": true
                },
                "peer1.org1.example.com": {
                    "endorsingPeer": true,
                    "chaincodeQuery": true,
                    "eventSource": true
                },
                "peer0.org2.example.com": {
                    "endorsingPeer": true,
                    "chaincodeQuery": true,
                    "eventSource": true
                },
                "peer1.org2.example.com": {
                    "endorsingPeer": true,
                    "chaincodeQuery": true,
                    "eventSource": true
                },
                "peer0.org3.example.com": {
                    "endorsingPeer": true,
                    "chaincodeQuery": true,
                    "eventSource": true
                },
                "peer1.org3.example.com": {
                    "endorsingPeer": true,
                    "chaincodeQuery": true,
                    "eventSource": true
                }

            }
        }
    },
    "organizations": {
        "Org1": {
            "mspid": "Org1MSP",
            "peers": [
                "peer0.org1.example.com",
                "peer1.org1.example.com"
            ],
            "certificateAuthorities": [
                "ca.org1.example.com"
            ]
        },
        "Org2": {
            "mspid": "Org2MSP",
            "peers": [
                "peer0.org2.example.com",
                "peer1.org2.example.com"
            ],
            "certificateAuthorities": [
                "ca.org2.example.com"
            ]
        },
        "Org3": {
            "mspid": "Org3MSP",
            "peers": [
                "peer0.org3.example.com",
                "peer1.org3.example.com"
            ],
            "certificateAuthorities": [
                "ca.org3.example.com"
            ]
        }

    },
    "orderers": {
        "orderer.example.com": {
            "url": "grpcs://orderer.example.com:7050",
            "grpcOptions": {
                "ssl-target-name-override": "orderer.example.com"
            },
            "tlsCACerts": {
                "pem": "$ord"
            }
        }
    },
    "peers": {
        "peer0.org1.example.com": {
            "url": "grpcs://peer0.org1.example.com:7051",
            "eventUrl": "grpcs://peer0.org1.example.com:7053",
            "grpcOptions": {
                "ssl-target-name-override": "peer0.org1.example.com"
            },
            "tlsCACerts": {
                "pem": "$org1"
            }
        },
        "peer1.org1.example.com": {
            "url": "grpcs://peer1.org1.example.com:8051",
            "eventUrl": "grpcs://peer1.org1.example.com:8053",
            "grpcOptions": {
                "ssl-target-name-override": "peer1.org1.example.com"
            },
            "tlsCACerts": {
                "pem": "$org1"
            }
        },
        "peer0.org2.example.com": {
            "url": "grpcs://peer0.org2.example.com:7051",
            "eventUrl": "grpcs://peer0.org2.example.com:7053",
            "grpcOptions": {
                "ssl-target-name-override": "peer0.org2.example.com"
            },
            "tlsCACerts": {
                "pem": "$org2"
            }
        },
        "peer1.org2.example.com": {
            "url": "grpcs://peer1.org2.example.com:8051",
            "eventUrl": "grpcs://peer1.org2.example.com:8053",
            "grpcOptions": {
                "ssl-target-name-override": "peer1.org2.example.com"
            },
            "tlsCACerts": {
                "pem": "$org2"
            }
        },
        "peer0.org3.example.com": {
            "url": "grpcs://peer0.org3.example.com:7051",
            "eventUrl": "grpcs://peer0.org3.example.com:7053",
            "grpcOptions": {
                "ssl-target-name-override": "peer0.org3.example.com"
            },
            "tlsCACerts": {
                "pem": "$org3"
            }
        },
        "peer1.org3.example.com": {
            "url": "grpcs://peer1.org3.example.com:8051",
            "eventUrl": "grpcs://peer1.org3.example.com:8053",
            "grpcOptions": {
                "ssl-target-name-override": "peer1.org3.example.com"
            },
            "tlsCACerts": {
                "pem": "$org3"
            }
        }
    },
    "certificateAuthorities": {
        "ca.org1.example.com": {
            "url": "https://ca.org1.example.com:7054",
            "caName": "ca-org1",
            "httpOptions": {
                "verify": false
            }
        },
        "ca.org2.example.com": {
            "url": "https://ca.org2.example.com:7054",
            "caName": "ca-org2",
            "httpOptions": {
                "verify": false
            }
        },
        "ca.org4.example.com": {
            "url": "https://ca.org3.example.com:7054",
            "caName": "ca-org3",
            "httpOptions": {
                "verify": false
            }
        }

    }
}
EOF

#composer card create -p /tmp/composer/org1/byfn-network-org1.json -u PeerAdmin -c /tmp/composer/org1/Admin@org1.example.com-cert.pem -k /tmp/composer/org1/*_sk -r PeerAdmin -r ChannelAdmin -f PeerAdmin@byfn-network-org1.card
#composer card create -p /tmp/composer/org2/byfn-network-org2.json -u PeerAdmin -c /tmp/composer/org2/Admin@org2.example.com-cert.pem -k /tmp/composer/org2/*_sk -r PeerAdmin -r ChannelAdmin -f PeerAdmin@byfn-network-org2.card
#composer card create -p /tmp/composer/org3/byfn-network-org3.json -u PeerAdmin -c /tmp/composer/org3/Admin@org3.example.com-cert.pem -k /tmp/composer/org3/*_sk -r PeerAdmin -r ChannelAdmin -f PeerAdmin@byfn-network-org3.card

#composer card import -f PeerAdmin\@byfn-network-org1.card --card PeerAdmin@byfn-network-org1
#composer card import -f PeerAdmin\@byfn-network-org2.card --card PeerAdmin@byfn-network-org2
#composer card import -f PeerAdmin\@byfn-network-org3.card --card PeerAdmin@byfn-network-org3





