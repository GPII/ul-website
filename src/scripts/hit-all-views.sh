#!/bin/bash

# CouchDB
curl --silent --show-error http://localhost:5984/ul/_design/eastin/_view/byisocode > /dev/null
curl --silent --show-error  http://localhost:5984/ul/_design/eastin/_view/manufacturerproductcount  > /dev/null
curl --silent --show-error  http://localhost:5984/ul/_design/eastin/_view/manufacturerproductcount?key="-1"  > /dev/null
curl --silent --show-error  http://localhost:5984/ul/_design/eastin/_view/manufacturers  > /dev/null
curl --silent --show-error  http://localhost:5984/ul/_design/eastin/_view/manufacturers?key="-1"  > /dev/null
curl --silent --show-error  http://localhost:5984/ul/_design/ul/_view/products?limit=1  > /dev/null
curl --silent --show-error  http://localhost:5984/ul/_design/ul/_view/records_by_source?limit=1  > /dev/null
curl --silent --show-error  http://localhost:5984/ul/_design/ul/_view/records_by_uid?limit=1  > /dev/null

# couchdb-lucene
curl --silent --show-error  http://localhost:5985/local/ul/_design/lucene/by_content  > /dev/null
curl --silent --show-error  http://localhost:5985/local/ul/_design/lucene/by_content?q="braille" > /dev/null
