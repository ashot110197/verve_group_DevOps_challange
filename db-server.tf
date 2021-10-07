resource "aws_db_instance" "default" {
  allocated_storage      = 10
  port                   = 3306
  engine                 = "mysql"
  engine_version         = "5.7"
  instance_class         = "db.t2.micro"
  name                   = "mydb"
  username               = "admin"
  password               = "admin123"
  parameter_group_name   = "default.mysql5.7"
  identifier             = "database"
  publicly_accessible    = false
  skip_final_snapshot    = true
  vpc_security_group_ids = [aws_security_group.web_app_sg.id]
  availability_zone      = var.availability_zone
}