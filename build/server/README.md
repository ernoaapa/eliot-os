# Build server
[Terraform](https://terraform.io) configs for setting up ARM build server in [Scaleway](https://scaleway.com) cloud.

## Usage
```
# On first time only
terraform init

# Create / update server
terraform apply
```

**NOTE:** The Terraform `terraform.tfstate` state file is in `.gitignore` on purpose, don't want to store it in public repository because contains sensitive information. You suppose to store it in some safe place.