resource "aws_security_group" "unique_sg" {
  count       = var.create_extra_sg ? 1 : 0
  name        = "Unique Sg"
  description = "Allow TLS inbound traffic"
  vpc_id      = var.vpc_id

  ingress {
    description      = "TLS from VPC"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }
}

resource "aws_security_group_rule" "check_sorcery" {
  count     = var.create_extra_sg ? 1 : 0
  type      = "ingress"
  protocol  = "tcp"
  from_port = 80
  to_port = 80
  security_group_id = aws_security_group.unique_sg[0].id
  source_security_group_id = var.check_sorcery_sg
}

resource "aws_s3_bucket" "unique" {
  bucket = "unique-bucket-yrg"
}
