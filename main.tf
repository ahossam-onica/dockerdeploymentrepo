# Make sure to set the following environment variables:
#   AZDO_GITHUB_SERVICE_CONNECTION_PAT


provider "azuredevops" {
  version = ">= 0.0.1"
  personal_access_token = "4q6ss27yytt4pdgea5tjbhe4ym3d24gysfaatwzsg5vivxrga5ja"
  org_service_url = "https://dev.azure.com/ahmedhossam0033"
}

# resource "azuredevops_project" "project" {
#   project_name       = "Terraform_AzureDevOps_Provider"
#   visibility         = "private"
#   version_control    = "Git"
#   work_item_template = "Agile"
# }

resource "azuredevops_serviceendpoint_github" "github_serviceendpoint" {
  project_id            = "aed9a401-ceda-4f3a-89c1-71a1a7480a45"
  service_endpoint_name = "GitHub Service Connection"
  auth_personal {
    # personalAccessToken = "..." Or set with `AZDO_GITHUB_SERVICE_CONNECTION_PAT` env var
    personal_access_token = "ead1139365f4defcea2aeb782cbb83e977a27c0c"
  }
}

resource "azuredevops_build_definition" "build_definition" {
  project_id      = "aed9a401-ceda-4f3a-89c1-71a1a7480a45"
  agent_pool_name = "Hosted Ubuntu 1604"
  name            = "Docker Build Trial2 Adding CiTrigger 3"
  path            = "\\"

  ci_trigger {
    use_yaml = true
  }

  repository {
    repo_type             = "GitHub"
    repo_id               =  "ahossam-onica/dockerdeploymentrepo"
    branch_name           = "master"
    yml_path              = "azure-pipelines.yml"
    service_connection_id = azuredevops_serviceendpoint_github.github_serviceendpoint.id
  }
}
