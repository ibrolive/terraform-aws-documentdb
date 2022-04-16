data "aws_vpc" "default" {
  default = true
}

// allow all access from anywhere for demo only
// restrict IPs or cidr blocks for production !!!
resource "aws_security_group" "allow_full_access" {
  name        = "allow_all"
  description = "Allow all inbound and outbound traffic"
  vpc_id      = data.aws_vpc.default.id

  ingress {
    from_port        = 0
    to_port          = 65535
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    from_port        = 0
    to_port          = 65535
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "allow_all"
  }
}