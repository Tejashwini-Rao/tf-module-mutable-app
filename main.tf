resource "aws_instance" "ONDEMAND" {
  od_count= var.ON_DEMAND_INSTANCE_COUNT
  od_type= var.ON_DEMAND_INSTANCE_TYPE
  ami = data.aws_ami.ami.image_id
  subnet_ids = data.terraform_remote_state.infra.outputs.app_subnets[count.index]
}

resource "aws_instance" "SPOT" {
  spot_count= var.SPOT_INSTANCE_COUNT
  spot_type= var.SPOT_INSTANCE_TYPE
  ami = data.aws_ami.ami.image_id
  wait_for_fulfillment   = true
  subnet_ids = data.terraform_remote_state.infra.outputs.app_subnets[count.index]
}

resource "aws_ec2_tag" "ONDEMAND" {
  count = length(local.all)
  resource_id = aws_instance.ONDEMAND.*.private_ip
  key         = "${var.ENV}-$(var.COMPONENT)"
  value       = "Hello World"
}

