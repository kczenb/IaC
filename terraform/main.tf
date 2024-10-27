provider "aws" {
  region = "us-east-1" 
}

resource "aws_instance" "app_instance" {
  ami           = "ami-0866a3c8686eaeeba"  
  instance_type = "t2.micro"               

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
