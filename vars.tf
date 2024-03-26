variable "env" {}
variable "tags" {}

variable "engine" {}
variable "backup_retention_period" {}
variable "preferred_backup_window" {}
variable "skip_final_snapshot" {}
variable "engine_version" {}
variable "subnet_ids" {}

variable "storage_encrypted" {
  default = true
}