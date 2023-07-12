resource "azurerm_kubernetes_cluster" "KubCluster" {
  name                = "MiClusterKubernetes"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  dns_prefix          = "MiKubernetesCluster"

  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = "Standard_B2s"
  }

  identity {
    type = "SystemAssigned"
  }

  tags = {
    Environment = "Education"
  }
}

resource "azurerm_role_assignment" "RolAssign" {
  principal_id = azurerm_kubernetes_cluster.KubCluster.kubelet_identity[0].object_id
  role_definition_name = "AcrPull"
  scope = azurerm_container_registry.acr.id
  skip_service_principal_aad_check = true
}

output "client_certificate" {
  value     = azurerm_kubernetes_cluster.KubCluster.kube_config.0.client_certificate
  sensitive = true
}

output "kube_config" {
  value = azurerm_kubernetes_cluster.KubCluster.kube_config_raw

  sensitive = true
}
