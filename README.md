# Fuseki Docker image for NFDI4Objects

[![Docker image](https://github.com/nfdi4objects/n4o-fuseki/actions/workflows/docker.yml/badge.svg)](https://github.com/nfdi4objects/n4o-fuseki/actions/workflows/docker.yml)

This [git repository](https://github.com/nfdi4objects/n4o-fuseki) contains sources to generate a Docker image configured to be used as Triple store of the [NFDI4Objects Knowledge Graph](https://graph.nfdi4objects.net/).

## Usage

File `docker-compose.yml` should contain everything needed to start Fuseki with configuration in `config.ttl`:

~~~sh
docker compose up
~~~

The container uses two volumes: `databases` and `logs`. Both most be writeable by user `1000` before starting the container:

~~~sh
mkdir databases ; sudo chown 1000:1000 databases
mkdir logs ; sudo chown 1000:1000 logs                  # not used unless logging to file is enabled
~~~

Fuseki is configured to provide the following APIs at <http://localhost:3030/n4o> (or at another port set with `PORT`) without authentification:

- SPARQL Query
- SPARQL Update
- Graph Store Protocol (read and write)

The default graph is set to the the union of all named graphs.

## Build and test

A [Docker image](https://github.com/nfdi4objects/n4o-fuseki/pkgs/container/n4o-fuseki) is automatically build via GitHub action (except for changes that only affect this Markdown file). The Jena version is hard-coded in [the workflow file](.github/workflows/docker.yml).

To locally build the image for testing:

~~~sh
docker compose build --build-arg JENA_VERSION=5.3.0
~~~

The script `test.sh` runs queries against all APIs to make sure data can be read and written (port can be set with `PORT`).

## License

Licensed under [Apache License](http://www.apache.org/licenses/) 2.0.

This product includes software developed at the [Apache Software Foundation](http://www.apache.org/).

The following sources have been copied from [Apache Jena Fuseki Docker Tools](https://github.com/apache/jena/tree/main/jena-fuseki2/jena-fuseki-docker):

- `Dockerfile`
- `download.sh`
- `entrypoint.sh`
- `log4j2.properties`
- `LICENSE`

This repository and the resulting Docker images are not affiliated with the Apache project.
