# cloudsql-database-plugin

## Purpose
This plugin is exactly the same as the existing postgrest/mysql/msql plugins, but can leverage Google's IAP, 
cross VPC access with private overlapping IPs, among other things.

This is different from the cloud sql proxy in that it more neatly integrated and turn-key.



IAP Tunnel User
oauth scopes on vault service account

create postgres role, must users name



# Tech info

https://www.vaultproject.io/
https://www.vaultproject.io/docs/secrets/databases/postgresql 
[https://www.vaultproject.io/docs/secrets/databases/custom](https://www.vaultproject.io/docs/secrets/databases/custom)

![./images/proxyconnection.svg](proxy)