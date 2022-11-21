##############################################################################
# Variables File
# 
# Here is where we store the default values for all the variables used in our
# Terraform code. If you create a variable with no default, the user will be
# prompted to enter it (or define it via config file or command line flags.)

variable "resource_group_location" {
  default     = "AustraliaCentral"
  description = "Location of the resource group."
}

variable "resource_group_name_prefix" {
  default     = "tf"
  description = "Prefix of the resource group name that's combined with a random ID so name is unique in your Azure subscription."
}

variable "app_gtw_sub" {
  description = "Name of the app gateway subnet"
  default     = ""
}

variable "app_gtw_ip" {
  description = "Name of the app gateway ip"
  default     = ""
}

variable "scale_set_sub" {
  description = "Name of the scale set subnet"
  default     = ""
}

variable "lb_sub" {
  default     = ""
  description = "Name of the Lb subnet"
}

variable "bastion_public_ip" {
  default     = ""
  description = "bastion public ip"
}

variable "bastion_subnet_id" {
  default     = ""
  description = "bastion subnet id"
}

variable "admin_user" {
  description = "User name to use as the admin account on the VMs that will be part of the VM scale set"
  default     = "azureuser"
}

variable "admin_password" {
  description = "Default password for admin account"
  default     = ""
}

variable "throughput" {
  type    = number
  default = 400
}