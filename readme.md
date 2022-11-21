<img width="300" alt="Terraform Logo" src=https://camo.githubusercontent.com/1a4ed08978379480a9b1ca95d7f4cc8eb80b45ad47c056a7cfb5c597e9315ae5/68747470733a2f2f7777772e6461746f636d732d6173736574732e636f6d2f323838352f313632393934313234322d6c6f676f2d7465727261666f726d2d6d61696e2e737667>

----------------

#N-Tier Architecture

<img width="300" alt="Architecture-diag" https://learn.microsoft.com/en-us/azure/architecture/guide/architecture-styles/images/n-tier-logical.svg>


-----------------
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | =3.26.0 |
| <a name="requirement_random"></a> [random](#requirement\_random) | ~>3.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | =3.26.0 |
| <a name="provider_random"></a> [random](#provider\_random) | ~>3.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_app-gateway"></a> [app-gateway](#module\_app-gateway) | ./modules/app_gateway | n/a |
| <a name="module_bastion-host"></a> [bastion-host](#module\_bastion-host) | ./modules/management_tools | n/a |
| <a name="module_biz_scale_sets"></a> [biz\_scale\_sets](#module\_biz\_scale\_sets) | ./modules/biz_scale_set | n/a |
| <a name="module_networks"></a> [networks](#module\_networks) | ./modules/networks | n/a |
| <a name="module_private-lb"></a> [private-lb](#module\_private-lb) | ./modules/load_balancer | n/a |
| <a name="module_web_scale_sets"></a> [web\_scale\_sets](#module\_web\_scale\_sets) | ./modules/web_scale_set | n/a |

## Resources

| Name | Type |
|------|------|
| [azurerm_resource_group.rg](https://registry.terraform.io/providers/hashicorp/azurerm/3.26.0/docs/resources/resource_group) | resource |
| [random_password.password](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |
| [random_pet.name](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/pet) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_admin_password"></a> [admin\_password](#input\_admin\_password) | Default password for admin account | `string` | `""` | no |
| <a name="input_admin_user"></a> [admin\_user](#input\_admin\_user) | User name to use as the admin account on the VMs that will be part of the VM scale set | `string` | `"azureuser"` | no |
| <a name="input_app_gtw_ip"></a> [app\_gtw\_ip](#input\_app\_gtw\_ip) | Name of the app gateway ip | `string` | `""` | no |
| <a name="input_app_gtw_sub"></a> [app\_gtw\_sub](#input\_app\_gtw\_sub) | Name of the app gateway subnet | `string` | `""` | no |
| <a name="input_bastion_public_ip"></a> [bastion\_public\_ip](#input\_bastion\_public\_ip) | bastion public ip | `string` | `""` | no |
| <a name="input_bastion_subnet_id"></a> [bastion\_subnet\_id](#input\_bastion\_subnet\_id) | bastion subnet id | `string` | `""` | no |
| <a name="input_lb_sub"></a> [lb\_sub](#input\_lb\_sub) | Name of the Lb subnet | `string` | `""` | no |
| <a name="input_resource_group_location"></a> [resource\_group\_location](#input\_resource\_group\_location) | Location of the resource group. | `string` | `"eastus"` | no |
| <a name="input_resource_group_name_prefix"></a> [resource\_group\_name\_prefix](#input\_resource\_group\_name\_prefix) | Prefix of the resource group name that's combined with a random ID so name is unique in your Azure subscription. | `string` | `"tf"` | no |
| <a name="input_scale_set_sub"></a> [scale\_set\_sub](#input\_scale\_set\_sub) | Name of the scale set subnet | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_app-gtw-ip"></a> [app-gtw-ip](#output\_app-gtw-ip) | n/a |
| <a name="output_application_gateway_name"></a> [application\_gateway\_name](#output\_application\_gateway\_name) | n/a |
| <a name="output_bastion-ip"></a> [bastion-ip](#output\_bastion-ip) | n/a |
| <a name="output_bastion_dns_name"></a> [bastion\_dns\_name](#output\_bastion\_dns\_name) | n/a |
| <a name="output_mid_tier_lb_name"></a> [mid\_tier\_lb\_name](#output\_mid\_tier\_lb\_name) | n/a |
| <a name="output_password"></a> [password](#output\_password) | n/a |
| <a name="output_resource_group_name"></a> [resource\_group\_name](#output\_resource\_group\_name) | n/a |
| <a name="output_subnet1_id"></a> [subnet1\_id](#output\_subnet1\_id) | n/a |
| <a name="output_subnet2_id"></a> [subnet2\_id](#output\_subnet2\_id) | n/a |
| <a name="output_subnet3_id"></a> [subnet3\_id](#output\_subnet3\_id) | n/a |
| <a name="output_subnet4_id"></a> [subnet4\_id](#output\_subnet4\_id) | n/a |
| <a name="output_subnet5_id"></a> [subnet5\_id](#output\_subnet5\_id) | n/a |
