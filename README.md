## Provision multiple AWS EC2 instance using Terraform

### Steps to provision aws ec2 instance with terraform :

- Clone repository
```
git clone https://github.com/rizkypanz16/terraform-aws-ec2-multiple_instance.git
```
- Change the configuration below with the aws configuration you have made 
```
<access_key>
<secret_key>
<sg-id>
<subnet-id>
<keypair-name>
```
- Plan - Preview changes before applying.
```
terraform plan
```
- Apply - Provision reproducible infrastructure.
```
terraform apply
```
