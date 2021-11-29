# UL API web site.

This repository contains the client-side code for the UL API web site, and the Docker files required to build and launch
it in production.

## Installation

### Prerequisites

To work with this package, you will need to have the following installed:

1. [Node.js](https://nodejs.org/en/) (currently we run using node@12)
2. `npm`
3. [Docker](https://www.docker.com).

### Installing Dependencies

To install the dependencies required to run standalone or run tests, run `npm install` from the root of the repository.

## Running the Tests

To run the tests associated with this package, run `npm test` from the root of the repository.

## Running Using `docker-compose`

Before you can run using `docker-compose`, you will need to create `/srv` and all of the subdirectories referenced in
the [`docker-compose.yml` file](./docker-compose.yml) in this repository.

Once those installation steps are complete, you can start the UL API with live server log messages using a command like:

`docker-compose up`

To stop services, break out of the session using Ctrl-C.  If you want to leave services running in the background, you
can use a command like:

`docker-compose up -d`

In that case, to stop services you will either need to issue the relative `docker` commands to stop individual containers
or stop and remove all containers using a command like:

`docker-compose down`

For additional options, consult the [`docker`](https://www.docker.com) and [`docker-compose`](https://docs.docker.com/compose/)
documentation.

Please note:  The first time you run, you will also need to synchronis the database
[as described here](./docs/syncing-couchdb.md).  

## Configuration Files Required for Docker

Key environment variables used within the three docker containers created by `docker-compose` are configured using
(non-version-controlled) files stored wherever you have the repository checked out.

### `.docker-env-couchdb`

| Field Name         | Description |
| ------------------ | ----------- |
| `COUCHDB_USER`     | The administrator username to configure for CouchDB. |
| `COUCHDB_PASSWORD` | The administrator password to configure for CouchDB. |

### `.docker-env-mail`

| Field Name    | Description |
| ------------- | ----------- |
| `HOSTS__SMTP` | The hostname on which the mail server is running. |

### `.docker-env-ul-imports`

| Field Name | Description |
| ---------- | ----------- |
| `USERNAME` | The UL API username to use when running imports. |
| `PASSWORD` | The UL API password to use when running imports. |
| `COMMIT`   | Set to `true` to commit any changes rather than simply previewing them. |

## Running Imports

The `ul-imports` container does not start and stay running in the background.  Rather, it is intended to be launched
to run a single named import, as in the following example, which synchronises the UL API with all remote data sources:

`docker-compose run ul-imports full-sync`

For the full list of supported commands, see the `package.json` file in the
[ul-imports repository](https://github.com/GPII/ul-imports/).

When the import scripts or configuration change, you will likely need to rebuild the `ul-imports` container, which can
be done using commands like:

```text
rm -rf node_modules/*
NODE_ENV=production npm install
docker-compose build ul-imports
```

## Running Standalone

If you already have your own CouchDB, couchdb-lucene, and mail server, you can just run the website and API as a
standalone service using a command like:

`node ./launch.ul.js`

## Running Tests

To run the tests in this package, run `npm test`.

## More Information

For a more detailed breakdown on executing common maintenance tasks, see [the operations handbook](./docs/operations.md).
If you need to make code changes, see the [contribution guidelines](./docs/contributing.md).
