variable "adminpw" {
  description = "the local admin password will be 12 character long"
  type        = string
  sensitive   = true
}

variable "web_linux_instance_count" {
  description = "web linux vm instance count"
  type = map(string)
  default = {
   "vm1" = "1022",
   "vm2" = "2022"
  }
}