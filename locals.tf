locals {
  spot_instance_instance = aws_instance.ONDEMAND.*.id
  on_demand_instance= aws_instance.SPOT.*.id
  all = concat(local.on_demand_instance,local.spot_instance_instance)
}