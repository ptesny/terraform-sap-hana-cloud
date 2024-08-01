resource "btp_subaccount" "this" {
  name      = var.subaccount_name
  subdomain = var.subdomain
  region    = var.region
}

module "sap_hana_cloud" {
  source                     = "github.com/ptesny/terraform-sap-hana-cloud"
  service_name               = "hana-cloud-trial"
  plan_name                  = "hana"
  hana_cloud_tools_app_name  = "hana-cloud-tools-trial"
  hana_cloud_tools_plan_name = "tools"  

  memory                     = 16
  vcpu                       = 1

  instance_name              = "hc-trial"
  admins                     = var.admins
  subaccount_id              = btp_subaccount.this.id
  whitelist_ips              = ["0.0.0.0/0"]
}
