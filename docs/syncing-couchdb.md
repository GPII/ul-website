# Syncing CouchDB

When performing local QA, it is expected that you test as much as possible with live data. This document covers
synchronising your local data with the live instance.  You'll want to remove any existing data to avoid conflicts
that would result from changes made in local testing.

1. Connect your browser to the CouchDB configuration endpoint at `http://localhost:5984/_utils`
2. Delete the existing `ul` database.
3. If you are testing changes to the image API or user logins, Delete the `images` and `users` databases as well.
   **NOTE: Only remove `users` (no leading underscore). Do not remove the built-in `_users` database.**
4. Open a tunnel to the live instance using a command like: `SSH -L ul-vm 15984:localhost:5984`
5. **Using the same local CouchDB configuration endpoint**, set up two jobs to replicate the live data as follows:
   1. Navigate to the "Replication" page in Fauxton
   2. Click "New Replication".
   3. Under "Source"
      1. Set the "Type" to "Remote Database"
      2. On OS X, the database URL is something like `https://docker.for.mac.localhost:15984/ul`.  For other
         platforms [see this issue](https://github.com/docker/for-linux/issues/264#issuecomment-966221821).
      3. Set the "Authentication" to "Username and password" and enter each.
   4. Under "Target"
      1. Set the "Type" to "New Local Database"
      2. Enter the database name, i.e. `ul`
      3. Set the "Authentication" to "Username and password" and enter each.
   5. Click "Start Replication"
   6. Monitor the replication page until you confirm that the replication is complete.
   7. If you are also testing changes to images or login functionality, repeat steps 2-6 for `images` and `users`.
6. Close the tunnel to the live instance.
