# handson-enviroment

## Let's setup.
### Replace text in `variable.tf` as below.
1. \<ipaddress\> -> xxx.xxx.xxx.xxx
1. \<password\>  -> xxxxxxxxxxxx (An alphabetic string of at least 12 characters, including uppercase, lowercase, and numbers)

### Execute terraform.
1. terraform init
1. terraform plan -out create-synapsae.plan
1. terraform apply "create-synapsae.plan"

