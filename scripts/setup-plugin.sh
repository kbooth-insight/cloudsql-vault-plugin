
vault login root

export SHA256=$(shasum -a 256 "vault-dev/plugins/cloudsql-database-plugin" | cut -d' ' -f1)

vault plugin register -sha256=$SHA256 secret cloudsql-database-plugin

vault secrets disable database
vault secrets enable database


 vault write \
    database/config/my-postgresql-database \
    plugin_name="postgresql-database-plugin" \
    allowed_roles="my-role" \
    connection_url="host=booth-custom-plugin-tests:us-central1:booth-test dbname=postgres sslmode=disable user={{username}} password={{password}} port=5432" \
    username="kevin.booth@insight.com" \
    password="ya29.A0ARrdaM_U925C4YVwc9LQ95QVq0u05Yd-3TGbxLZtkNJbHbcjSZwPVsA7YHCBQPEJQKLuiK5y5vXN-Tb70MZcZucVDZQ5MsFlHs90zeLNq6FEo27Eom4Xe0lKWjyPO5aT-fyMMdJ9_W81TZ3lt5LPxl-H1deOTvqKH-pQwQ" \
    verify_connection="true"


vault write database/roles/my-role \
    db_name=my-postgresql-database \
    creation_statements="CREATE ROLE \"{{name}}\" WITH LOGIN PASSWORD '{{password}}' VALID UNTIL '{{expiration}}'; \
        GRANT SELECT ON ALL TABLES IN SCHEMA public TO \"{{name}}\";" \
    default_ttl="1h" \
    max_ttl="24h"