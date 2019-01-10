# terraform-and-gcp-blueprints
Various Terraform blueprints examples for building out infrastructure on Google Cloud Platform

Depending on what you're building, you may get an error telling you you need a particualr API enabled for GCP (i.e. `Cloud Dataproc API` for dataproc_cluster or `Google Cloud Storage JSON API` for storage_bucket)

Tested for Terraform version < 0.12.0

```
terraform init 

terraform plan -var 'project_id=my_project-1234' -var 'credentials_file_path=~/my_credentials.json' -var 'ssh_user=glen' -var 'public_key_file_path=~/glen_rsa.pub' -var 'private_key_file_path=~/glen_rsa'

terraform apply -var 'project_id=my_project-1234' -var 'credentials_file_path=~/my_credentials.json' -var 'ssh_user=glen' -var 'public_key_file_path=~/glen_rsa.pub' -var 'private_key_file_path=~/glen_rsa'

terraform destroy -var 'project_id=my_project-1234' -var 'credentials_file_path=~/my_credentials.json' -var 'ssh_user=glen' -var 'public_key_file_path=~/glen_rsa.pub' -var 'private_key_file_path=~/glen_rsa'
```

Optionally, you can add:

```
scheduling {
  preemptible = "true"
}
```

to your compute instance config so that you don't accidentally accumulate a huge bill if you forget to run `terraform destroy` afterwards.
