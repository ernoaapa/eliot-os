# Build in Packet
Notes how to build ElliotOS in Packet ARM based server.

1. Start new server in Packet
- Type A2
- Ubuntu 16.04 LTS
- Amsterdam

2. SSH to the server

3. Install Go
```shell
sudo add-apt-repository -y ppa:gophers/archive
sudo apt update
sudo apt-get install -y git golang-1.9-go
ln -s /usr/lib/go-1.9/bin/go /usr/local/bin/go
```

4. Install Moby & Linuxkit
```shell
go get -u github.com/moby/tool/cmd/moby
go get -u github.com/linuxkit/linuxkit/src/cmd/linuxkit
```

5. Install Docker
```shell
sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo apt-key fingerprint 0EBFCD88

sudo add-apt-repository "deb https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

sudo apt-get update
sudo apt-get install -y docker-ce
```

6. Clone repository
```shell
  # TODO
```

7. Build RasperryPI image
```shell
export PATH="$PATH:/root/go/bin"
moby build -format rpi3 linuxkit.yml
```

8. Download image

```shell
scp root@<ip>:./linuxkit.tar .
```