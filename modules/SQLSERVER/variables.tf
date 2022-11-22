
variable "location" {
  description = "Location of the resource"
}

variable "resource_group_name" {
  description = "Name of the resource group name that's combined with a random ID so name is unique in your Azure subscription."
}

variable "servername" {
  description = "Name of the resources"
}

variable "dbname" {
  description = "Name of database to create"
  default     = "mydb"
}

variable "adminlogin" {
  default = "dbadmin"
}

variable "adminpwd" {
}

variable "apisubnetid" {
  description = "id of api subnet.  used to configure service endpoint"

}