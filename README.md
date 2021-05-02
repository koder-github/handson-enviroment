# handson-enviroment

## Let's setup.
### Replace text in `variable.tf` as below.
1. \<ipaddress\> -> xxx.xxx.xxx.xxx
1. \<password\>  -> xxxxxxxxxxxx (An alphabetic string of at least 12 characters, including uppercase, lowercase, and numbers)
1. \<cloudshellipaddress\> -> xxx.xxx.xxx.xxx (get cloudshell ipaddress (eg. ```curl ipinfo.io/ip```)) </br> If you don't use cloudshell, please delete "```, "<cloudshellipaddress>```"
1. \<client_user_id\> -> xxx@xxxx.onmicrosoft.com(or @\<custom domain\>) (Your Login ID for Azure AD)
1. \<client_object_id\> -> xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx (Your Login ID (eg. ```(Get-AzADUser -UserPrincipalName "xxx@xxx.onmicrosoft.com").Id```))
### Execute terraform.
1. terraform init
1. terraform plan -out create-synapsae.plan
1. terraform apply "create-synapsae.plan"
