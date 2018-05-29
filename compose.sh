#!/bin/bash
#Install compose 0.19.4
su - hyper <<EOF
npm config set registry http://registry.npm.taobao.org
npm uninstall -g composer-cli
npm uninstall -g  composer-rest-server
npm uninstall -g generator-hyperledger-composer
npm uninstall -g yo
npm uninstall -g composer-playground
npm install -g composer-cli@0.19.4
npm install -g composer-rest-server@0.19.4;
npm install -g generator-hyperledger-composer@0.19.4;
npm install -g yo;
npm install -g composer-playground@0.19.4;
EOF
