resource "btp_subaccount" "this" {
  name      = var.subaccount_name
  subdomain = var.subdomain
  region    = var.region
}

module "sap_hana_cloud" {
  source        = "github.com/ptesny/terraform-sap-hana-cloud"
  instance_name = "hc-trial"
  admins        = var.admins
  subaccount_id = btp_subaccount.this.id
  whitelist_ips = ["0.0.0.0/0"]
}
