resource "aws_default_vpc" "default" {
  tags {
    Name = "Default VPC"
  }
}

# When Terraform adopts a security group, it removes all ingress and egress rules
# This is consistent with the security best-practics of removing AWS default ingress and egress rules
resource "aws_default_security_group" "default" {
  vpc_id = "${aws_default_vpc.default.id}"
}
