provider "aws" {
  region     = var.region
  access_key = var.access_key
  secret_key = var.secret_key
}

resource "aws_key_pair" "ssh-key" {
        key_name        = "ssh-key"
        public_key      = var.aws_ssh-key
}

resource "aws_instance" "php-fpm_nginx" {
  ami                     = var.ami_latest
  instance_type           = var.instance_type
  vpc_security_group_ids  = [aws_security_group.php-fpm_nginx_security_group.id]
  key_name                = aws_key_pair.ssh-key.id
  provisioner "local-exec" {
    command = "sleep 120; ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -u ubuntu --private-key ~/.ssh/test.pem  -i ${aws_instance.php-fpm_nginx.public_ip}, ../ansible/php-fpm_nginx/master.yml"
  }
}

resource "aws_instance" "mysql" {
  ami                     = var.ami_latest
  instance_type           = var.instance_type
  vpc_security_group_ids  = [aws_security_group.mysql_security_group.id]
  key_name                = aws_key_pair.ssh-key.id
  provisioner "local-exec" {
    command = "sleep 120; ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -u ubuntu --private-key ~/.ssh/test.pem -i ${aws_instance.mysql.public_ip}, ../ansible/mysql/master.yml"
  }
}
