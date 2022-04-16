resource "aws_docdb_cluster" "docdb" {
  cluster_identifier      = "my-docdb-cluster"
  master_username         = "user1"     //
  master_password         = "password" // use secrets manager or parameter store for production workloads !!!
  backup_retention_period = 0
  preferred_backup_window = "07:00-09:00"
  skip_final_snapshot     = true
  engine_version          = "3.6.0"
  port                    = "27017"
  availability_zones      = ["us-east-1a"]
  vpc_security_group_ids  = [aws_security_group.allow_full_access.id]
}

resource "aws_docdb_cluster_instance" "cluster_instances" {
  count              = 1
  identifier         = "docdb-cluster-instance-${count.index}"
  availability_zone  = "us-east-1a"
  apply_immediately  = true
  cluster_identifier = aws_docdb_cluster.docdb.id
  instance_class     = "db.t3.medium"
}