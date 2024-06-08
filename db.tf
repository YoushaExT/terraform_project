# db.tf
resource "aws_db_instance" "postgresql" {
  engine                 = "postgres"
  db_name                = "postgres_db"
  identifier             = "postgres-identifier"
  instance_class         = "db.t4g.micro"
  allocated_storage      = 20
  publicly_accessible    = true
  username               = var.db_username
  password               = var.db_password
  vpc_security_group_ids = [aws_security_group.postgres_sg.id]
  skip_final_snapshot    = true

  tags = {
    Name = "postgres-db"
  }
}

output "db_endpoint" {
  value       = aws_db_instance.postgresql.endpoint
  description = "The endpoint of the database"
}
