![Docker Pulls](https://img.shields.io/docker/pulls/juanformoso/devpi_docker.svg)

### Summary

Docker container for using devpi server with ubuntu, heavily inspired by (and some things borrowed from) [apihackers/docker-devpi](https://github.com/apihackers/docker-devpi)

Docker image hosted in https://hub.docker.com/r/juanformoso/devpi_docker/

### Getting the image

    docker pull juanformoso/devpi_docker

### Running your private pypi server

The `$DEVPI_PASSWORD` environment variable will set the root password on first run.

```bash
docker run -e "DEVPI_PASSWORD=password" -d -p 3141:3141 --name devpi juanformoso/devpi_docker
```

To mount your own local devpi cache directory:

```bash
docker run -d -v /path/to/devpi/home:/devpi juanformoso/devpi_docker
```

#### pip

Use a configuration similar to this in your `~/.pip/pip.conf`:

```ini
[global]
index-url = http://localhost:3141/root/pypi/+simple/
```

#### setuptools

Use a configuration similar to this in your `~/.pydistutils.cfg`:

```ini
[easy_install]
index_url = http://localhost:3141/root/pypi/+simple/
```
