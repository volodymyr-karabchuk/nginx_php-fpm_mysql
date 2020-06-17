provider "aws" {
  region     = "eu-central-1"
  access_key = "${ACCESS_KEY}"
  secret_key = "${SECRET_KEY}"
}

resource "aws_security_group" "php-fpm_nginx_security_group" {
  name        = "php-fpm_nginx_security_group"
  dynamic "ingress" {
    for_each = ["22", "80", "443"]
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "mysql_security_group" {
  name        = "mysql_security_group"
  dynamic "ingress" {
    for_each = ["22", "3306"]
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


resource "aws_instance" "php-fpm_nginx" {
  ami                     = "ami-0e342d72b12109f91"
  instance_type           = "t2.micro"
  vpc_security_group_ids  = [aws_security_group.php-fpm_nginx_security_group.id]
}

resource "aws_instance" "mysql" {
  ami           = "ami-0e342d72b12109f91"
  instance_type = "t2.micro"
  vpc_security_group_ids  = [aws_security_group.mysql_security_group.id]
}
