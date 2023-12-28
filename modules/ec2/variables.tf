variable "wp_sg" {
  description = "ID of the Wordpress security group"
  type        = string
  default     = "ssh-access"
}

variable "db_sg" {
  description = "ID of the Db security group"
  type        = string
  default     = "ssh-access"
}
