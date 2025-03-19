# Fuseki Docker image for NFDI4Objects

[![Docker image](https://github.com/nfdi4objects/n4o-fuseki/actions/workflows/docker.yml/badge.svg)](https://github.com/orgs/nfdi4objects/packages/container/package/n4o-fuseki)

This [git repository](https://github.com/nfdi4objects/n4o-fuseki) contains sources to generate a Docker image configured to be used as Triple store of the [NFDI4Objects Knowledge Graph](https://graph.nfdi4objects.net/).

## Installation

A container can be started for testing with one command:

~~~sh
docker run ghcr.io/nfdi4objects/n4o-fuseki:main
~~~

For stable deployment better use a `docker-compose.yml` instead. See [docker-compose.yml](docker-compose.yml) from this repository for reference.

The container can optionally be attached to with two volumes:

- `databases` to store database outside of the container
- `logs` to write logfiles (not used yet as logging to file is not enabled)

Both directories must be writeable by user `1000` before starting the container:

~~~sh
mkdir databases ; sudo chown 1000:1000 databases
mkdir logs ; sudo chown 1000:1000 logs
~~~

Then create and start the container:

~~~sh
docker compose up
~~~

## Usage

Fuseki is [configured](config.ttl) to provide the following APIs at <http://localhost:3030/n4o> (or at another port set with `PORT`) without authentification:

- SPARQL Query
- SPARQL Update
- Graph Store Protocol (read and write)

The default graph is set to the the union of all named graphs.

There is no graphical user interface. Please use <https://github.com/nfdi4objects/n4o-graph-apis> as frontend.

To import data into the triple store use <https://github.com/nfdi4objects/n4o-graph-importer> to make sure the data conforms to requirements of the Knowledge Graph.

## Build and test

A [Docker image](https://github.com/nfdi4objects/n4o-fuseki/pkgs/container/n4o-fuseki) is automatically build via GitHub action (except for changes that only affect this Markdown file).

To locally build the image for testing:

~~~sh
docker compose build
~~~

The script [`test-apis.sh`](test-apis.sh) runs queries against all APIs to make sure data can be read and written (port can be set with `PORT`).

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
