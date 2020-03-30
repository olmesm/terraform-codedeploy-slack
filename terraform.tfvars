namespace = "nym"
stage     = "dev"
name      = "einstein"
common_tags = {
  "Managed by" = "Terraform"
}

repo_owner = "daddyroi"
repo_name  = "einstein-django"
branch     = "mvp-ecs"

# build_image = "aws/codebuild/standard:4.0"
build_image = "aws/codebuild/docker:18.09.0"
buildspec   = "buildspec.yml"
AWS_REGION  = "eu-west-1"
image_tag   = "1"

environment_variables = [
  {
    name  = "ENV"
    value = "prod"
  }
]

app_port_main = 3000
