resource "aws_docdb_cluster" "docdb" {
  cluster_identifier      = "${var.env}-docdb"
  engine                  = var.engine
  engine_version          = var.engine_version
  master_username         = data.aws_ssm_parameter.user.value
  master_password         = data.aws_ssm_parameter.pass.value
  backup_retention_period = var.backup_retention_period
  preferred_backup_window = var.preferred_backup_window
  skip_final_snapshot     = var.skip_final_snapshot
  db_subnet_group_name    = aws_docdb_subnet_group.main.name
  kms_key_id              = data.aws_kms_key.key.arn
  storage_encrypted       = var.storage_encrypted
}

resource "aws_docdb_subnet_group" "main" {
  name       = "${var.env}-docdb"
  subnet_ids = var.subnet_ids

  tags = merge(
    var.tags,
    { Name = "${var.env}-subnet-group" }
  )
}

resource "aws_docdb_cluster_instance" "cluster_instances" {
  count              = var.no_of_instances
  identifier         = "${var.env}-docdb-${count.index}"
  cluster_identifier = aws_docdb_cluster.docdb.id
  instance_class     = var.instance_class
}

resource "aws_ssm_parameter" "docdb_url_catalogue" {
  name  = "${var.env}.docdb.url.catalogue"
  type  = "String"
  value = "aa"
}

resource "aws_ssm_parameter" "docdb_url_users" {
  name  = "${var.env}.docdb.url.users"
  type  = "String"
  value = "aa"
}

resource "aws_ssm_parameter" "docdb_endpoint" {
  name  = "${var.env}.docdb.endpoint"
  type  = "String"
  value = aws_docdb_cluster.docdb.endpoint
}