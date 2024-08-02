output "dbadmin_password" {
  value = jsondecode(btp_subaccount_service_binding.hc_binding_dbadmin.instances[0])
}

output "sap_hana_cloud_central" {
  value = btp_subaccount_subscription.hana_cloud_tools.subscription_url
}
