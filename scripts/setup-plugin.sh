

# setup
export CLOUDSQL_INSTANCEID=$1
export GOOGLE_AUTH_TOKEN=$2

if [[ "${GOOGLE_AUTH_TOKEN}" == "" ]]
then
  echo "no token in GOOGLE_AUTH_TOKEN...setting"
  export GOOGLE_AUTH_TOKEN=$(gcloud auth application-default print-access-token)
fi

if [[ "${CLOUDSQL_INSTANCEID}" == "" ]]
then
  export CLOUDSQL_INSTANCEID="booth-custom-plugin-tests:us-central1:booth-test"
  export CLOUDSQL_DBNAME="postgres"
  export CLOUDSQL_USER="kevin.booth@insight.com"
fi



vault login root

export SHA256=$(shasum -a 256 "vault-dev/plugins/cloudsql-database-plugin" | cut -d' ' -f1)

vault plugin register -sha256=$SHA256 secret cloudsql-database-plugin
vault secrets disable database
vault secrets enable database


 vault write \
    database/config/my-cloudsql-database \
    plugin_name="postgresql-database-plugin" \
    allowed_roles="my-role" \
    connection_url="host=booth-custom-plugin-tests:us-central1:booth-test dbname=postgres sslmode=disable user=kbooth password=C@rdinal2030 port=5432" \
    username="kbooth" \
    password="C@rdinal2030" \
    verify_connection="true"

vault write database/roles/my-role \
    db_name=my-cloudsql-database \
    creation_statements="CREATE ROLE \"{{name}}\" WITH LOGIN PASSWORD '{{password}}' VALID UNTIL '{{expiration}}'; \
        GRANT SELECT ON ALL TABLES IN SCHEMA public TO \"{{name}}\";" \
    default_ttl="1h" \
    max_ttl="24h"

vault read database/creds/my-role