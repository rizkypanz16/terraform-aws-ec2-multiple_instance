## membuat multiple aws instance dengan terraform

terraform {
    required_providers {
        aws = {
            source = "hashicorp/aws"
            version = "4.49.0"
        }
    }
}

# mendefinisikan provider setting
provider "aws" {
    access_key = "<access_key>"                                     # rubah <access_key> dengan aws api access_key milik anda
    secret_key = "<secret_key>"                                     # rubah <secret_key> dengan aws api secret_key milik anda
    region     = "us-east-1"                                        # rubah region dengan region yang anda inginkan
}

# mendefinisikan aws_security_group
data "aws_security_group" "selected" {
    id		    = "<sg-id>"                                         # rubah <sg-id> dengan security group yang telah ada / dibuat
}

# membuat aws_instance
resource "aws_instance" "aws-ubuntu-node" {
    count			            = 2						                    # jumlah instance yang akan dibuat
    ami                         = "ami-06878d265978313ca"			        # ubuntu server 22.04 LTS
    instance_type               = "t2.micro"					            # memilih instance t2.micro untuk free tier eligible
    vpc_security_group_ids      = [data.aws_security_group.selected.id]		# mengambil id dari aws_security_group yang telah dibuat sebelumnya
    subnet_id		            = "<subnet-id>"			                    # rubah <subnet_id> dengan subnet_id yang telah ada / dibuat
    associate_public_ip_address = true              					    # melakukan asosiasi ippublic untuk aws_instance
    key_name			        = "<keypair-name>"					        # rubah <keypair-name> dengan keypai yang telah ada / dibuat

    tags = {
        Name	= "tf-ubuntunode-${count.index}"				            # mendeskripsikan nama instance
    }

    root_block_device {
        volume_size	= 25							                        # mendefinisikan aws ebs volume size
        # encrypted	= true							                        # encrypted ebs volume (optional)
        tags        = {
            Name    = "tf-ubuntunode-disk-${count.index}"                   # mendeskripsikan nama ebs volume
        }
    }

}

# menampilkan beberapa output untuk ip public aws_instance
output "instance_ip" {
    value = "${join(",", aws_instance.aws-ubuntu-node.*.public_ip)}"
}

