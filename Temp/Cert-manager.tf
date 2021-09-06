variable resource_group_name {}
variable location {}
variable dns_zone_id {}

# Creates Identity
resource "azurerm_user_assigned_identity" "dns_identity" {
  name                = "cert-manager-dns01"
  resource_group_name = var.resource_group_name
  location            = var.location
}

# Creates Role Assignment
resource "azurerm_role_assignment" "dns_contributor" {
  scope                = var.dns_zone_id
  role_definition_name = "DNS Zone Contributor"
  principal_id         = azurerm_user_assigned_identity.dns_identity.principal_id
}

# Client Id Used for identity binding
output "identity_client_id" {
  value = azurerm_user_assigned_identity.dns_identity.client_id
}

# Resource Id Used for identity binding
output "identity_resource_id" {
  value = azurerm_user_assigned_identity.dns_identity.id
}
