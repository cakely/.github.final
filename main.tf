provider "github" {
  token        = var.github_token
  organization = var.github_organization
  anonymous    = false
}

data "github_repository" "app_repo" {
  full_name = "${var.github_organization}/app"
}

resource "github_branch_protection" "app_branch_protection" {
  repository     = data.github_repository.app_repo.name
  branch         = "master"
  enforce_admins = true

  required_status_checks {
    strict   = true
    contexts = ["Terraform"]
  }

  required_pull_request_reviews {
    dismiss_stale_reviews           = false
    required_approving_review_count = 1
  }
}
