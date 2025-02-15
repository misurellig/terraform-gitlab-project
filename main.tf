/**
 * # Terraform GitLab Project
 *
 * Terraform module to create GitLab projects.
 *
 * ## Usage
 * see [examples](./examples).
 */

resource "gitlab_project" "project" {
  for_each = var.projects

  # required
  name         = each.value.name
  namespace_id = each.value.namespace_id

  # optional
  allow_merge_on_skipped_pipeline                  = lookup(each.value, "allow_merge_on_skipped_pipeline", false)
  approvals_before_merge                           = lookup(each.value, "approvals_before_merge", 0)
  archive_on_destroy                               = lookup(each.value, "archive_on_destroy", null)
  archived                                         = lookup(each.value, "archived", false)
  auto_cancel_pending_pipelines                    = lookup(each.value, "auto_cancel_pending_pipelines", "enabled")
  auto_devops_enabled                              = lookup(each.value, "auto_devops_enabled", false)
  build_coverage_regex                             = lookup(each.value, "build_coverage_regex", "")
  ci_config_path                                   = lookup(each.value, "ci_config_path", "")
  ci_forward_deployment_enabled                    = lookup(each.value, "ci_forward_deployment_enabled", true)
  container_registry_enabled                       = lookup(each.value, "container_registry_enabled", true)
  default_branch                                   = lookup(each.value, "default_branch", "master")
  description                                      = lookup(each.value, "description", "")
  group_with_project_templates_id                  = lookup(each.value, "group_with_project_templates_id", null)
  import_url                                       = lookup(each.value, "import_url", "")
  initialize_with_readme                           = lookup(each.value, "initialize_with_readme", null)
  issues_enabled                                   = lookup(each.value, "issues_enabled", true)
  issues_template                                  = lookup(each.value, "issues_template", "")
  lfs_enabled                                      = lookup(each.value, "lfs_enabled", true)
  merge_method                                     = lookup(each.value, "merge_method", "merge")
  merge_pipelines_enabled                          = lookup(each.value, "merge_pipelines_enabled", false)
  merge_requests_enabled                           = lookup(each.value, "merge_requests_enabled", true)
  merge_requests_template                          = lookup(each.value, "merge_requests_template", "")
  merge_trains_enabled                             = lookup(each.value, "merge_trains_enabled", false)
  mirror                                           = lookup(each.value, "mirror", false)
  mirror_overwrites_diverged_branches              = lookup(each.value, "mirror_overwrites_diverged_branches", false)
  mirror_trigger_builds                            = lookup(each.value, "mirror_trigger_builds", false)
  only_allow_merge_if_all_discussions_are_resolved = lookup(each.value, "only_allow_merge_if_all_discussions_are_resolved", true)
  only_allow_merge_if_pipeline_succeeds            = lookup(each.value, "only_allow_merge_if_pipeline_succeeds", true)
  only_mirror_protected_branches                   = lookup(each.value, "only_mirror_protected_branches", false)
  packages_enabled                                 = lookup(each.value, "packages_enabled", true)
  pages_access_level                               = lookup(each.value, "pages_access_level", "private")
  path                                             = lookup(each.value, "path", each.value.name) # set name as path
  printing_merge_request_link_enabled              = lookup(each.value, "printing_merge_request_link_enabled", true)
  public_builds                                    = lookup(each.value, "public_build", false)
  remove_source_branch_after_merge                 = lookup(each.value, "remove_source_branch_after_merge", true)
  request_access_enabled                           = lookup(each.value, "request_access_enabled", true)
  shared_runners_enabled                           = lookup(each.value, "shared_runners_enabled", false)
  snippets_enabled                                 = lookup(each.value, "snippets_enabled", true)
  squash_option                                    = lookup(each.value, "squash_option", "default_off")
  tags                                             = lookup(each.value, "tags", ["v*"])
  template_name                                    = lookup(each.value, "template_name", null)
  template_project_id                              = lookup(each.value, "template_project_id", null)
  use_custom_template                              = lookup(each.value, "use_custom_template", null)
  visibility_level                                 = lookup(each.value, "visibility_level", "private")
  wiki_enabled                                     = lookup(each.value, "wiki_enabled", true)

  dynamic "push_rules" {
    for_each = lookup(each.value, "push_rules", null) != null ? [1] : []
    content {
      commit_committer_check        = lookup(each.value.push_rules, "commit_committer_check", false)
      deny_delete_tag               = lookup(each.value.push_rules, "deny_delete_tag", false)
      max_file_size                 = lookup(each.value.push_rules, "max_file_size", 0)
      member_check                  = lookup(each.value.push_rules, "member_check", false)
      prevent_secrets               = lookup(each.value.push_rules, "prevent_secrets", false)
      reject_unsigned_commits       = lookup(each.value.push_rules, "reject_unsigned_commits", false)
      author_email_regex            = lookup(each.value.push_rules, "author_email_regex", "")
      branch_name_regex             = lookup(each.value.push_rules, "branch_name_regex", "")
      commit_message_negative_regex = lookup(each.value.push_rules, "commit_message_negative_regex", "")
      commit_message_regex          = lookup(each.value.push_rules, "commit_message_regex", "")
      file_name_regex               = lookup(each.value.push_rules, "file_name_regex", "")
    }
  }
}

resource "gitlab_branch_protection" "master" {
  for_each           = var.projects
  project            = gitlab_project.project[each.key].id
  branch             = var.main_branch_to_protect
  merge_access_level = "developer"
}

resource "gitlab_tag_protection" "tags" {
  for_each            = var.projects
  project             = gitlab_project.project[each.key].id
  tag                 = "v*"
  create_access_level = "developer"
}
