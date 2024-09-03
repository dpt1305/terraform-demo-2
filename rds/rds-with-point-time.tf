variable "db_password" {
  type = string
  description = "password of database"
}
variable "subnet_id_1" {
  type = string
  description = "existing subnet id"
}
variable "subnet_id_2" {
  type = string
  description = "existing subnet id"
}

resource "aws_db_subnet_group" "default" {
  name       = "main"
  subnet_ids = [var.subnet_id_1, var.subnet_id_2]

  tags = {
    Name = "My DB subnet group"
  }
}

resource "aws_db_instance" "rds_sample" {
    allocated_storage = 10
    db_name = "udacity_db"
    engine = "mysql"
    engine_version = "8.0"
    instance_class = "db.t3.micro"
    username = "udacity"
    password = var.db_password
    backup_retention_period = 1
    backup_window = "08:15-08:55"
    skip_final_snapshot = true
    db_subnet_group_name = aws_db_subnet_group.default.id
}