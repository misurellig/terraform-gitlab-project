# Apex

Example of apex project creation in the GitLab namespace `<namespace_id>`.

```
module "apex" {
  source = "../../"
  projects = {
    apex = {
      name                          = "apex"
      namespace_id                  = <namespace_id>
      initialize_with_readme        = false
      public_build                  = false
      ci_config_path                = "<ci_config_path_file>"
      auto_cancel_pending_pipelines = "enabled"
      shared_runners_enabled        = false
    }
  }
  main_branch_to_protect = "main"
}
```

## Provider configurations

Set up the GitLab provider with your customisations in the `configurations.tf` file.

## Usage

Initialize, plan and apply the module configurations.

```
$ terraform init
$ terraform plan
$ terraform apply
```
