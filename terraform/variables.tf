variable "region" {
        default         = "eu-central-1"
        description     = "AWS_Region"
}

variable "access_key" {
        default         = "${AWS_ACCESS_KEY}"
        description     = "Access Key"
}

variable "secret_key" {
        default         = "${AWS_SECRET_KEY}"
        description     = "Secret Key"
}

variable "instance_type" {
        default         = "t2.micro"
        description     = "Instance type"
}

variable "ami_latest" {
        default         = "ami-0e342d72b12109f91"
        description     = "AMI"
}

variable "aws_ssh-key" {
        default         = "ssh-rsa ${PUBLIC_SSH_KEY}"
        description     = "ssh-key"
}


