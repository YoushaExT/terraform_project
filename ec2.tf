# ec2.tf

# FRONTEND

resource "aws_instance" "ubuntu_frontend_instance" {
  ami                    = "ami-04b70fa74e45c3917" # Ubuntu 24.04 LTS - US East AMI ID
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.public[0].id
  key_name               = "test"
  vpc_security_group_ids = [aws_security_group.ubuntu_sg.id]
  tags = {
    Name = "tf_created_ec2_ubuntu_frontend"
  }

  root_block_device {
    volume_size = 8
    volume_type = "gp3"
  }

  user_data = templatefile("${path.module}/ec2_userdata/frontend_userdata.tftpl", {
    frontend_domain = var.frontend_domain,
    backend_domain  = var.backend_domain,
    frontend_port   = var.frontend_port
  })
}

output "frontend_ip" {
  value       = aws_instance.ubuntu_frontend_instance.public_ip
  description = "The frontend ip address"
}

resource "aws_instance" "ubuntu_backend_instance" {
  ami                    = "ami-04b70fa74e45c3917" # Ubuntu 24.04 LTS - US East AMI ID
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.public[1].id
  key_name               = "test"
  vpc_security_group_ids = [aws_security_group.ubuntu_sg.id]
  tags = {
    Name = "tf_created_ec2_ubuntu_backend"
  }

  root_block_device {
    volume_size = 8
    volume_type = "gp3"
  }

  user_data = templatefile("${path.module}/ec2_userdata/backend_userdata.tftpl", {
    backend_domain = var.backend_domain,
    backend_port   = var.backend_port,
    db_endpoint    = aws_db_instance.postgresql.endpoint,
    db_username    = aws_db_instance.postgresql.username,
    db_password    = var.db_password
  })
}

output "backend_ip" {
  value       = aws_instance.ubuntu_backend_instance.public_ip
  description = "The backend ip address"
}

resource "aws_instance" "ubuntu_metabase_instance" {
  ami                    = "ami-04b70fa74e45c3917" # Ubuntu 24.04 LTS - US East AMI ID
  instance_type          = "t2.small"              # 2GB RAM because Metabase needs a lot of memory
  subnet_id              = aws_subnet.public[2].id
  key_name               = "test"
  vpc_security_group_ids = [aws_security_group.ubuntu_sg.id]
  tags = {
    Name = "tf_created_ec2_ubuntu_metabase"
  }

  root_block_device {
    volume_size = 8
    volume_type = "gp3"
  }

  user_data = templatefile("${path.module}/ec2_userdata/metabase_userdata.tftpl", {
    metabase_domain = var.metabase_domain,
    metabase_port   = var.metabase_port
  })

  # # METABASE .env setup - NOT working as metabase runs some weird migrations and then fails
  # user_data = templatefile("${path.module}/ec2_userdata/metabase_userdata.tftpl", {
  #   metabase_domain = var.metabase_domain,
  #   metabase_port   = var.metabase_port
  #   db_endpoint     = aws_db_instance.postgresql.endpoint,
  #   db_username     = aws_db_instance.postgresql.username,
  #   db_password     = var.db_password
  # })
}

output "metabase_ip" {
  value       = aws_instance.ubuntu_metabase_instance.public_ip
  description = "The metabase ip address"
}
