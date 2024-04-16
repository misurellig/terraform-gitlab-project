module "apex" {
  source = "../"
  projects = {
    apex = {
      name                          = "apex"
      namespace_id                  = <id_namespace_destinazione>
      initialize_with_readme        = false
      public_build                  = false
      ci_config_path                = <ci_config_path>
      auto_cancel_pending_pipelines = "enabled"
      shared_runners_enabled        = false
    }
  }
  main_branch_to_protect = "main"
}
