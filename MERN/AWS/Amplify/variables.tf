variable "tag_name" {
  description = "Value of the tag for the Amplify"
  type        = string
  default     = "Rahul-tf-Amplify"
}

variable "repo_url" {
  description = "Value of the repo URL of react app"
  type        = string
}

variable "github_access_token" {
  description = "Value of the github access token"
  type        = string
}

variable "backend_url" {
  description = "Value of the url of backend server"
  type        = string
}

variable "branch_name" {
  description = "Value of the repo branch to deploy to Amplify"
  type        = string
  default     = "master"
}

variable "domain_name_amp" {
  description = "Value of the domain name for domain association in Amplify"
  type        = string
}
variable "subdomain_name_amp" {
  description = "Value of the subdomain name for domain association in Amplify"
  type        = string
}

variable "count_value" {
  description = "Boolean value whether to associate domain or not"
  type = bool
}
