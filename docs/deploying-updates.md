# Deploying Updates

Before deploying changes, you are expected to test them locally by rebuilding the relevant containers.

## Rebuilding containers

To rebuild the ul-website container, run a command like the following from the root of this repository:

```shell
docker build . -t ul-website:latest
```

To rebuild the ul-imports container, [see the documentation in the ul-imports repository](https://github.com/GPII/ul-imports/).

Once you have a new container image to test, you can deploy it locally using commands like the following from the root
of this repository:

```shell
docker-compose down
docker-compose up -d.
```

## Performing QA

At a minimum, you should verify that the website functions as expected, and that imports run.  To verify that the
website functions as expected:

1. Start the composition (see above).
2. [Synchronise your CouchDB container with production](./syncing-couchdb.md).
3. Connect a browser to `https://localhost:4896/`.
4. Verify that all static pages are served as expected.
5. Test the search functionality (the first search may fail or take a long time as the Lucene index is rebuilt).
6. Navigate to an individual record and verify that that content appears as expected.
7. Verify that logging in works as expected.
8. Perform a full synchronisation using the ul-imports VM works without errors (see [the README](../README.md) for
   details).

## Deploying to Production

Once you are satisfied that the updated container(s) are working as expected, you will need to copy the container
image to production.  From your local machine, save the updated container(s) using commands like:

```shell
docker save ul-website | gzip > /tmp/ul-website.tar.gz
docker save ul-imports | gzip > /tmp/ul-imports.tar.gz
scp /tmp/ul-*.tar.gz ul-vm:
```

You'll then need to SSH to the ul-vm, and run commands like the following:

```shell
gunzip ul-website.tar.gz
sudo docker import ul-website
cd /srv/ul-website
sudo docker-compose down
sudo docker-compose up -d
```

You should perform the same QA steps following deployment.
