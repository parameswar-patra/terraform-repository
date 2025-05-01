# RDS
resource "aws_db_instance" "my_db_instance" {
  allocated_storage       = 20
# max_allocated_storage   = 100
  identifier              = "primary-db"
  engine                  = "mysql"
  engine_version          = "8.0"
  instance_class          = "db.t3.micro"
  storage_type            = "gp2"

  username                = "parameswar"
  password                = "parameswar_2003"
  db_name                 = "my-db-instance"
  port                    = 3306

  
  
  db_subnet_group_name    = aws_db_subnet_group.my_RDS_subnet_group.id
  parameter_group_name    = "default.mysql8.0"
  vpc_security_group_ids  = [aws_security_group.my_SG_1.id]
  multi_az                = false
  publicly_accessible     = true
  availability_zone       = "us-east-1a"
  network_type            = "IPV4"

  
  
  # Enable backups and retention
  backup_retention_period  = 7   # Retain backups for 7 days
  backup_window            = "02:00-03:00" # Daily backup window (UTC)

  
  
  # Enable monitoring (CloudWatch Enhanced Monitoring)
  monitoring_interval      = 60  # Collect metrics every 60 seconds
  monitoring_role_arn      = aws_iam_role.rds_monitoring.arn
  enabled_cloudwatch_logs_exports = ["error", "general", "slowquery"]
  
  
  
  # Enable performance insights
  # performance_insights_enabled          = true
  # performance_insights_retention_period = 7  # Retain insights for 7 days

  
  
  maintenance_window = "sun:04:00-sun:05:00"  # Maintenance every Sunday (UTC)
  auto_minor_version_upgrade = true   # Automatically apply minor version upgrades (e.g., from MySQL 8.0.32 → 8.0.35) during the maintenance_window.Recommended for security and stability updates.Set to false if you need full manual control of upgrades.
  apply_immediately          = false  # recomended for production environment,not for dev/test.for dev/test recomended is true.
  deletion_protection        = true   # Prevent accidental deletion	
  skip_final_snapshot        = true   # recomended is false,purpose:it will Control whether AWS should take a final snapshot of the DB before deletion.
  final_snapshot_identifier  = "final-snapshot-example"  # (Required only if skip_final_snapshot = false.),Specifies the name of the snapshot AWS will create when the DB is deleted.Must be unique within the region/account.
  
  
  
  # Storage Encryption
  # storage_encrypted       = true
  # kms_key_id              = aws_kms_key.rds_key.arn

}

# IAM Role for RDS Enhanced Monitoring
resource "aws_iam_role" "rds_monitoring" {
  name = "rds-monitoring-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "monitoring.rds.amazonaws.com"
      }
    }]
  })
}

# IAM Policy Attachment for RDS Monitoring
resource "aws_iam_role_policy_attachment" "rds_monitoring_attach" {
  role       = aws_iam_role.rds_monitoring.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonRDSEnhancedMonitoringRole"
}

# read replica
resource "aws_db_instance" "my_read_replica" {
  provider               = aws.secondary
  
  allocated_storage      = 20
  identifier             = "read-replica"
  engine                 = "mysql"
  engine_version         = "8.0"
  port                   = "3306"
  instance_class         = "db.t3.micro"
  storage_type           = "gp2"

  replicate_source_db = aws_db_instance.my_db_instance.arn
  multi_az = false
  publicly_accessible  = true
  depends_on = [aws_db_instance.my_db_instance]
}