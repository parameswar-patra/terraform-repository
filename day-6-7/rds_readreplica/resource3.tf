# RDS
resource "aws_rdb_instance" "my_rds_instance_1" {
  allocated_storage      = 20
  identifier             = "my-rds-instance-1"
  db_name                = "primarydb"
  engine                 = "mysql"
  engine_version         = "8.0"
  instance_class         = "db.t3.micro"
  storage_type           = "gp2" # extra
  storage_encrypted      = true # extra
  username               = "parameswar"
  password               = "parameswar_2003"
  db_subnet_group_name   = [aws_db_subnet_group.my_RDS_subnet_group.id]
  parameter_group_name   = "default.mysql8.0"
  vpc_security_group_ids = [aws_security_group.my_SG_1.id] # extra
  
  backup_retention_period = 7
  backup_window          = "03:00-04:00"
  maintenance_window     = "Mon:04:00-Mon:05:00"
  deletion_protection    = true
  skip_final_snapshot    = true
  monitoring_interval    = 60

  publicly_accessible    = true # extra
  multi_az               = false  # extra
  apply_immediately      = true # extra
  auto_minor_version_upgrade = true # extra
  enabled_cloudwatch_logs_exports = ["error", "general", "slowquery"] # extra

  tags = {
    Name = "Primary RDS Instance"
  }
}

resource "aws_db_instance" "read_replica" {
  identifier             = "read-replica-db"
  engine                 = "mysql"
  instance_class         = "db.t3.micro"
  replicate_source_db    = aws_db_instance.primary.id
  db_subnet_group_name   = aws_db_subnet_group.rds_subnet_group.name
  vpc_security_group_ids = [aws_security_group.rds_sg.id]
  publicly_accessible    = false
  storage_type           = "gp2"
  monitoring_interval    = 60
  auto_minor_version_upgrade = true
  apply_immediately      = true

  tags = {
    Name = "Read Replica RDS"
  }
}