#!/bin/bash

echo "Starting Keycloak server..."

# Start Keycloak server in the background
/opt/keycloak/bin/kc.sh start-dev &

# Wait for Keycloak to fully start
echo "Waiting 60 seconds to import settings..."
sleep 60

# Check if the lock file exists
if [ ! -f /opt/keycloak/data/imported.lock ]; then
  # Authenticate and create the realm
  echo "Configuring credentials..."
  /opt/keycloak/bin/kcadm.sh config credentials --server http://localhost:8080 --realm master --user admin --password admin

  echo "Creating realm..."
  /opt/keycloak/bin/kcadm.sh create realms -f /opt/keycloak/shopping-realm.json

  echo "Adding default users..."
  /opt/keycloak/bin/kcadm.sh create users -o -r shopping-realm -f /opt/keycloak/shopping-realm-users-0.json
  /opt/keycloak/bin/kcadm.sh create users -o -r shopping-realm -f /opt/keycloak/shopping-realm-users-1.json

  # Mark import as done
  touch /opt/keycloak/data/imported.lock
  echo "Realm import completed."

else
  echo "Not the first run: skipping import"
fi

# Wait indefinitely to keep the container running
tail -f /dev/null
