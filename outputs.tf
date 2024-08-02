output "sap_hana_cloud_central" {
  value = btp_subaccount_subscription.hana_cloud_tools.subscription_url
}


output "dbadmin_credentials" {
  value = data.btp_subaccount_service_binding.hc_binding_dbadmin_data.credentials
}
