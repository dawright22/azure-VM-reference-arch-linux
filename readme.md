<img width="300" alt="Terraform Logo" src=https://camo.githubusercontent.com/1a4ed08978379480a9b1ca95d7f4cc8eb80b45ad47c056a7cfb5c597e9315ae5/68747470733a2f2f7777772e6461746f636d732d6173736574732e636f6d2f323838352f313632393934313234322d6c6f676f2d7465727261666f726d2d6d61696e2e737667>

----------------

# N-Tier Architecture

<img width="600" alt="Architecture-diag" src=https://learn.microsoft.com/en-us/azure/architecture/guide/architecture-styles/images/n-tier-logical.svg>

Layers are a way to separate responsibilities and manage dependencies. Each layer has a specific responsibility. A higher layer can use services in a lower layer, but not the other way around.

Tiers are physically separated, running on separate machines. A tier can call to another tier directly, or use asynchronous messaging (message queue). Although each layer might be hosted in its own tier, that's not required. Several layers might be hosted on the same tier. Physically separating the tiers improves scalability and resiliency, but also adds latency from the additional network communication.

A traditional three-tier application has a presentation tier, a middle tier, and a database tier. The middle tier is optional. More complex applications can have more than three tiers. The diagram above shows an application with two middle tiers, encapsulating different areas of functionality.

An N-tier application can have a closed layer architecture or an open layer architecture:

In a closed layer architecture, a layer can only call the next layer immediately down.
In an open layer architecture, a layer can call any of the layers below it.
A closed layer architecture limits the dependencies between layers. However, it might create unnecessary network traffic, if one layer simply passes requests along to the next layer.

## When to use this architecture
N-tier architectures are typically implemented as infrastructure-as-service (IaaS) applications, with each tier running on a separate set of VMs. However, an N-tier application doesn't need to be pure IaaS. Often, it's advantageous to use managed services for some parts of the architecture, particularly caching, messaging, and data storage.

## Consider an N-tier architecture for:

- Simple web applications.
- Migrating an on-premises application to Azure with minimal refactoring.
- Unified development of on-premises and cloud applications.
- N-tier architectures are very common in traditional on-premises applications, so it's a natural fit for migrating existing workloads to Azure.

## What we build

<img width="800" alt="Architecture-diag2" src=https://learn.microsoft.com/en-us/azure/architecture/guide/architecture-styles/images/n-tier-physical-bastion.png>

## How to deploy

1. Open a cloud Shell from the Azure portal
2. Clone this repo by running this command:
```
git clone https://github.com/dawright22/azure-VM-reference-arch-linux.git
```
3. Change into the directory this created
4. Now copy and Run this command:
```HCL
Terraform init
```
6. Now copy and Run this command:
 ``` 
 Terraform apply
 ```

That's all Fokes! [to quote bugs bunny]

If you want to customise location or other componets then you can start playing with the Variables file to suit you.

To access the VM scale sets select the instance you wish to connect to and use the Bastion option as per these instructions https://learn.microsoft.com/en-us/azure/bastion/bastion-connect-vm-scale-set. 
Enter azureuser as the user and use the generated password from Terraform by running
```
terraform output password
```
in your cloud shell session.
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
