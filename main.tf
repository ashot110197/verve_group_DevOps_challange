terraform {
    required_providers {
        aws = {
            source = "hashicorp/aws"
            version = "~> 3.0"
        }
    }
}

#configure the AWS Provider
provider "aws" {
    region = var.region
}

# Executing ansible playbook
resource "null_resource" "run-ansible-playbook" {
  provisioner "local-exec" {
    command = "ansible-playbook -T 300 main.yml"
  }
  # Run after aws ruby instance is ready
  depends_on = [aws_instance.ruby_instance]

}
