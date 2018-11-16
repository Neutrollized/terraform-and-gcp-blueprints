# terraform-and-gcp-blueprints
Various Terraform blueprints examples for building out infrastructure on Google Cloud Platform

```
terraform apply -var 'project_id=my_project-1234' -var 'credentials_file_path=~/my_credentials.json' -var 'ssh_user=glen' -var 'public_key_file_path=~/glen_rsa.pub' -var 'private_key_file_path=~/glen_rsa'
```
