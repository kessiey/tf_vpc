
# AWS VPC module for Terraform

A lightweight VPC module for Terraform.

## Usage

```hcl
module "vpc_basic" {
  source = "github.com/kessiey/tf_vpc"

  name = "vpc_name"

  cidr = "10.0.0.0/16"
  public_subnet = "10.0.1.0/24"
}
```


![Screenshot 2024-06-16 002732](https://github.com/kessiey/tf_vpc/assets/122237149/b95e2ada-3517-4b4c-9125-289a83557e8a)


See `interface.tf` for additional configurable variables.

## License

MIT

