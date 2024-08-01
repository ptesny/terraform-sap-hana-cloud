resource "btp_subaccount" "this" {
  name      = var.subaccount_name
  subdomain = var.subdomain
  region    = var.region
}

module "hana_cloud" {
  source        = "ptesny/hana-cloud/sap"
  version       = "0.0.1"
  instance_name = "hana-cloud"
  admins        = var.admins
  subaccount_id = btp_subaccount.this.id
  whitelist_ips = ["0.0.0.0/0"]
}
