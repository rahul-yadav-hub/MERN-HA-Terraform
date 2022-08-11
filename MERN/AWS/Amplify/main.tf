resource "aws_amplify_app" "amplify" {
  name       = var.tag_name
  repository = var.repo_url
  # GitHub personal access token
  access_token = var.github_access_token
  enable_branch_auto_build = true

  build_spec = <<-EOT
    version: 1
    frontend:
      phases:
        preBuild:
          commands:
            - npm install
        build:
          commands:
            - echo "REACT_APP_BACKEND_URI=$BACKEND_URI" >> .env
            - npm run build
      artifacts:
        baseDirectory: build
        files:
          - '**/*'
        cache:
          paths:
            - node_modules/**/*
  EOT
  environment_variables = {
    BACKEND_URI = var.backend_url
  }
  
}

resource "aws_amplify_branch" "branch" {
  app_id      = aws_amplify_app.amplify.id
  branch_name = var.branch_name

}

resource "aws_amplify_domain_association" "domain" {
  count = var.count_value ? 1 : 0
  app_id      = aws_amplify_app.amplify.id
  domain_name = var.domain_name_amp
  sub_domain {
    branch_name = aws_amplify_branch.branch.branch_name
    prefix      = var.subdomain_name_amp
  }
}
// Run Build
resource "null_resource" "run_build" {
  depends_on = [
    aws_amplify_app.amplify
  ]
  provisioner "local-exec" {
    command = "aws amplify start-job --app-id ${aws_amplify_app.amplify.id} --branch-name ${var.branch_name} --job-type RELEASE --profile sqops"
//    interpreter = ["pwsh", "-Command"]
  }
}
