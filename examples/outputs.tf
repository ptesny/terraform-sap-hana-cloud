output "sap_hana_cloud_central" {
  value = module.sap_hana_cloud.sap_hana_cloud_central
}


output "dbadmin_credentials" {
  sensitive = true
  value = module.sap_hana_cloud.dbadmin_credentials
}