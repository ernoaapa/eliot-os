# EliotOS
EliotOS is minimal Linux Operating System, built with [Linuxkit](https://github.com/linuxkit/linuxkit), which contains only minimal components to run [Eliot](https://github.com/ernoaapa/eliot).

- [Linux kernel](https://github.com/linuxkit/linuxkit/tree/master/kernel)
- [containerd](https://github.com/containerd/containerd) - Container runtime
- [runc](https://github.com/opencontainers/runc) - Run containers based on OCI specification
- [eliotd](https://github.com/ernoaapa/eliot) - Primary node agent which manages containers based on specs

## Run locally
### Prerequisites
- [Moby](https://github.com/moby/moby)
- [Linuxkit](https://github.com/linuxkit/linuxkit)

### Build
```
moby build linuxkit.yml
```

### Run
```shell
sudo linuxkit run hyperkit -cpus 4 -mem "1024" -disk size=10G -networking vmnet linuxkit
```
