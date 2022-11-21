##############################################################################
# Variables File
# 
# Here is where we store the default values for all the variables used in our
# Terraform code. If you create a variable with no default, the user will be
# prompted to enter it (or define it via config file or command line flags.)

variable "resource_group_location" {
  description = "Location of the resource group."
}

variable "resource_group_name" {
  description = "Name of the resource group name that's combined with a random ID so name is unique in your Azure subscription."
}

variable "name" {
  description = "Name of the resources"
}

variable "bastion_public_ip" {
  default     = ""
  description = "bastion public ip"
}

variable "bastion_subnet_id" {
  default     = ""
  description = "bastion subnet id"
}