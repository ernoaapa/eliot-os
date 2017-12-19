# EliotOS
EliotOS is minimal Linux Operating System, built with [Linuxkit](https://github.com/linuxkit/linuxkit), which contains only minimal components to run [Eliot](https://github.com/ernoaapa/eliot).

- [Linux kernel](https://github.com/linuxkit/linuxkit/tree/master/kernel)
- [containerd](https://github.com/containerd/containerd) - Container runtime
- [runc](https://github.com/opencontainers/runc) - Run containers based on OCI specification
- [eliotd](https://github.com/ernoaapa/eliot) - Primary node agent which manages containers based on specs

## Usage
At the moment, there's pre-built image for RaspberryPI 3 available.

## RaspberryPI 3
1. Format sd card to FAT32
2. Download pre-built image from [releases](https://github.com/ernoaapa/eliot-os/releases)
3. Unpack image to the sd card
4. Eject card and boot RaspberryPI

### Run locally
#### Prerequisites
- [Go 1.9.x](https://golang.org/)
- [Linuxkit](https://github.com/linuxkit/linuxkit) `go get -u github.com/linuxkit/linuxkit/src/cmd/linuxkit`

#### Build
```
linuxkit build rpi3.yml
```

#### Run
```shell
sudo linuxkit run hyperkit -cpus 4 -mem "1024" -disk size=10G -networking vmnet rpi3
```
