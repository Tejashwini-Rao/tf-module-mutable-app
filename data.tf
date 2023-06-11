
data "aws_ssm_parameter" "ssh_credentials" {
  name = "ssh.credentials"
}

data "aws_ami" "ami" {
  most_recent = true
  name_regex  = "new-allow"
  owners      = ["9177412919"]
}

data "terraform_remote_state" "infra" {
  backend = "s3"
  config = {
    bucket = "terraform-t66"
    key    = "mutable/infra/dev/terraform.tfstate"
    region = "us-east-1"
  }
}