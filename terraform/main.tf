provider "aws" {
  region = "us-east-1" 
}

resource "aws_security_group" "node_app_sg" {
  name        = "node_app_security_group"
  description = "Allow inbound traffic on port 3000"

  ingress {
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Open to all IPs; restrict as needed
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"  # Allows all outbound traffic
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "app_instance" {
  ami           = "ami-0866a3c8686eaeeba"  
  instance_type = "t2.micro"
  security_groups = [aws_security_group.node_app_sg.name]               

  tags = {
    Name = "NodeApp"
  }

  # Optional: Add user_data script to install Node.js and start your app
  user_data = <<-EOF
              #!/bin/bash
              sudo yum update -y
              sudo yum install -y git
              sudo yum install -y nodejs npm
              # Clone and start the app
              git clone https://github.com/kczenb/IaC.git /home/ubuntu/app
              cd /home/ubuntu/app
              npm install
              npm start &
              EOF
}

output "instance_ip" {
  value = aws_instance.app_instance.public_ip
}
