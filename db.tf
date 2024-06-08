# db.tf

resource "aws_db_subnet_group" "rds_private_subnet_group" {
  name       = "rds-private-subnet-group"
  subnet_ids = [for subnet in aws_subnet.private : subnet.id]

  tags = {
    Name = "RDS private subnet group"
  }
}

resource "aws_db_instance" "postgresql" {
  engine                 = "postgres"
  db_name                = "postgres_db"
  identifier             = "postgres-identifier"
  instance_class         = "db.t4g.micro"
  allocated_storage      = 20
  username               = var.db_username
  password               = var.db_password
  vpc_security_group_ids = [aws_security_group.postgres_sg.id]
  skip_final_snapshot    = true
  db_subnet_group_name = aws_db_subnet_group.rds_private_subnet_group.name

  tags = {
    Name = "postgres-db"
  }
}

output "db_endpoint" {
  value       = aws_db_instance.postgresql.endpoint
  description = "The endpoint of the database"
}
