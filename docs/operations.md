# Unified Listing Operations Handbook

This document is intended to act as a reference for various maintenance tasks related to the
[https://api.ul.gpii.net/](Unified Listing API).

## Background

The Unified Listing API was developed as a companion effort to the GPII (now Morphic).  It is written using
[Infusion](https://docs.fluidproject.org/infusion/development/), a Javascript framework that runs both in
[Node.js](https://nodejs.org/en/) and in the browser.  The data stored in the Unified Listing API is housed in
[CouchDB](http://couchdb.apache.org).  This data is indexed for searches using
[couchdb-lucene](https://github.com/rnewson/couchdb-lucene).

All parts of the Unified listing website except for nginx are [Docker containers](https://www.docker.com) that are
configured to work together using [Docker compose](https://docs.docker.com/compose/), which creates containers for
the website and import runner, and also creates companion containers for CouchDB and couchdb-lucene.

These containers run in [AWS](https://aws.amazon.com/) and are accessible via SSH.  For access to that VM,
contact [Gregg Vanderheiden](mailto:gregg@rtf.org).  The host instance runs [CentOS](https://www.centos.org) 7.9.
For the rest of this document, this is referred to as `ul-vm` (you can easily create an alias by editing your
`~/.ssh/config file`).

## Common Tasks

1. [Installing and configuring the UL API](../README.md)
2. [Stopping and starting the UL API](../README.md)
3. [Running imports](../README.md)
4. [Deploying updates](./deploying-updates.md)

## Backups and Disaster Recovery

The most critical content required to rebuild the UL API is the CouchDB data found in the `/srv/docker-couchdb_data`
directory on the `ul-vm`.  For details on how this content is backed up and restored, contact
[Christopher Walker](mailto:christopher@raisingthefloor.org).

There is also image content found in `/srv/ul-images`, but if a backup is not available, this can be recreated by
running a full sync [(see the README for details.)](../README.md).

## Support Life

The most critical software the UL API depends on has a published support window, after which security and bug fixes may
no longer be provided.  `ul-vm` uses Centos 7, which is supported until [June 30th, 2024](https://centos.org/cl-vs-cs/).

The UL website container uses node@8, which is no longer supported.  The code itself has been tested with
node@14, it's likely that this can be updated if there are maintenance hours available.  The UL imports container has
been updated to run using node@16, which is supported [until April 30th, 2024](https://nodejs.org/en/about/releases/).

The `ul-website` and `ul-imports` containers are built on top of
[docker containers provided by nodejs.org](https://hub.docker.com/_/node).  These use Alpine Linux.  The `ul-imports`
container has been updated recently and runs Alpine `3.14`, which is supported until
[May 1st, 2023](https://alpinelinux.org/releases/).  The `ul-website` container already runs an unsupported version of
Alpine Linux.  If there are maintenance hours available, it's likely that we can easily update to a supported version
with a few hours of work.

The version of CouchDB in current use (2.2) is no longer supported, and only the latest version of CouchDB 2.x is
supported.  It's likely that we could update to a supported version of CouchDB 2.x if there are maintenance hours.  It
should not take long to verify whether the system works with CouchDB 3.x, it may also be possible to upgrade to that
with a couple of hours of work.

### Npm dependencies

In addition, the npm dependencies of this package have their own support life and security fixes.  To check for security
issues, it is recommended to periodically run `npm audit` in all repositories.  There are currently a number of critical
vulnerabilities in the libraries we use.  If there are any maintenance hours, update as many packages as possible.

To check for unsupported packages, it is good practice to periodically run `npx check-is-deprecated -f` in all
repositories.  The UL API already uses a number of deprecated packages, if there are any maintenance hours, update as
many packages as possible.
