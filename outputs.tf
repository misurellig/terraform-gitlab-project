output "project_name" {
  value = [
    for k, v in gitlab_project.project : v.name
  ]
}

output "project_id" {
  value = [
    for k, v in gitlab_project.project : v.id
  ]
}

output "project_web_url" {
  value = [
    for k, v in gitlab_project.project : v.web_url
  ]
}

output "project_full_path" {
  value = [
    for k, v in gitlab_project.project : v.path_with_namespace
  ]
}

output "project_namespace_id" {
  value = [
    for k, v in gitlab_project.project : v.namespace_id
  ]
}

