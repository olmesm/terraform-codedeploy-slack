variable "AWS_REGION" {
  default = "eu-west-1"
}

variable "namespace" {
  type        = string
  description = "Namespace (e.g. `eg` or `cp`)"
  default     = ""
}

variable "stage" {
  type        = string
  description = "Stage (e.g. `prod`, `dev`, `staging`)"
  default     = "dev"
}

variable "name" {
  type        = string
  description = "Name of the application"
}

variable "common_tags" {
  type        = map(string)
  description = "Additional tags (_e.g._ { BusinessUnit : ABC })"
  default     = {}
}

variable "repo_owner" {
  type        = string
  description = "GitHub Organization or Username"
}

variable "repo_name" {
  type        = string
  description = "GitHub repository name of the application to be built and deployed to ECS"
}

variable "branch" {
  type        = string
  description = "Branch of the GitHub repository, _e.g._ `master`"
}
variable "buildspec" {
  type        = string
  default     = ""
  description = "Declaration to use for building the project. [For more info](http://docs.aws.amazon.com/codebuild/latest/userguide/build-spec-ref.html)"
}

variable "image_tag" {
  type        = string
  default     = "latest"
  description = "Docker image tag in the ECR repository, e.g. 'latest'. Used as CodeBuild ENV variable when building Docker images. [For more info](http://docs.aws.amazon.com/codebuild/latest/userguide/sample-docker.html)"
}

variable "environment_variables" {
  type = list(object(
    {
      name  = string
      value = string
  }))

  default     = []
  description = "A list of maps, that contain both the key 'name' and the key 'value' to be used as additional environment variables for the build"
}

variable GITHUB_TOKEN {
  description = "You'll need to set TF_VAR_GITHUB_TOKEN as an env variable"
  default     = ""
}

variable build_image {
  type        = string
  default     = ""
  description = "Docker image for build environment, _e.g._ `aws/codebuild/docker:docker:18.09.0`"
}

variable app_port_main {
  type        = number
  default     = null
  description = "Main port the app will be running off"
}
