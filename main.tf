resource "btp_subaccount_entitlement" "entitlements" {
  subaccount_id = var.subaccount_id
  service_name  = "hana-cloud"
  plan_name     = "hana-td"
}

resource "btp_subaccount_entitlement" "name" {
  subaccount_id = var.subaccount_id
  service_name  = var.hana_cloud_tools_app_name
  plan_name     = var.hana_cloud_tools_plan_name
}

resource "btp_subaccount_role_collection_assignment" "hana_admin" {
  subaccount_id        = var.subaccount_id
  for_each             = var.admins == null ? {} : { for user in var.admins : user => user }
  role_collection_name = "SAP HANA Cloud Administrator"
  user_name            = each.value
  depends_on = [
    btp_subaccount_subscription.hana_cloud_tools,
  ]
}

resource "btp_subaccount_role_collection_assignment" "hana_viewer" {
  subaccount_id        = var.subaccount_id
  for_each             = var.viewers == null ? {} : { for user in var.viewers : user => user }
  role_collection_name = "SAP HANA Cloud Viewer"
  user_name            = each.value
  depends_on = [
    btp_subaccount_subscription.hana_cloud_tools,
  ]
}

resource "btp_subaccount_role_collection_assignment" "hana_security_admin" {
  subaccount_id        = var.subaccount_id
  for_each             = var.security_admins == null ? {} : { for user in var.security_admins : user => user }
  role_collection_name = "SAP HANA Cloud Security Administrator"
  user_name            = each.value
  depends_on = [
    btp_subaccount_subscription.hana_cloud_tools,
  ]
}

resource "btp_subaccount_subscription" "hana_cloud_tools" {
  subaccount_id = var.subaccount_id
  app_name      = var.hana_cloud_tools_app_name
  plan_name     = var.hana_cloud_tools_plan_name
  depends_on    = [btp_subaccount_entitlement.entitlements]
}

data "btp_subaccount_service_plan" "my_hana_plan" {
  subaccount_id = var.subaccount_id
  name          = "hana-td"
  offering_name = "hana-cloud"
  depends_on = [
    btp_subaccount_entitlement.entitlements
  ]
}

#Create or Update an SAP HANA Cloud database instance
resource "btp_subaccount_service_instance" "my_sap_hana_cloud_instance" {
  subaccount_id  = var.subaccount_id
  serviceplan_id = data.btp_subaccount_service_plan.my_hana_plan.id
  name           = var.instance_name
  parameters = jsonencode({
    data = {
      memory                 = var.memory
      vcpu                   = var.vcpu
      generateSystemPassword = true
      whitelistIPs           = ["0.0.0.0/0"]
      databaseMappings = var.database_mappings
    }
  })
  # labels = var.labels
  depends_on = [
    btp_subaccount_subscription.hana_cloud_tools
  ]
}
