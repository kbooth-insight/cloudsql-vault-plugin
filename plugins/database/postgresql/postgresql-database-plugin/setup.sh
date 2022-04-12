
rm -rf ./vault-data/*

vault secrets disable database
vault secrets enable database

 vault write \
    database/config/my-postgresql-database \
    plugin_name="postgresql-database-plugin" \
    allowed_roles="root" \
    connection_url="booth-custom-plugin-tests:us-central1:booth-test" \
    username="kevin.booth@insight.com" \
    password="ya29.A0ARrdaM86IHumYQS8C_VibZpGotwWbtU1xmoIqJE_aMWG2RQXZYI6iYdh2tNhjn_Qk5cbr4XVWXEWiqsHkznqt0rdFV7-eMSIoaPc4wURwjF-cHxGXIIn5gzViqChVJ_dU266HVjevLyqKJa1yCDKrM9moQ7ECS7h2PzyPw"
