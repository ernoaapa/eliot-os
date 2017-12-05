#!/bin/bash

sudo add-apt-repository -y ppa:gophers/archive
sudo apt update
sudo apt-get install -y git golang-1.9-go
ln -s /usr/lib/go-1.9/bin/go /usr/local/bin/go

go get -u github.com/moby/tool/cmd/moby
go get -u github.com/linuxkit/linuxkit/src/cmd/linuxkit

sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo apt-key fingerprint 0EBFCD88

sudo add-apt-repository "deb https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

sudo apt-get update
sudo apt-get install -y docker-ce
