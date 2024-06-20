module "variable_account"{
 source= "./../../variables"
}
locals {
    s3_name = "bucket-${module.variable_account.account_id}"
}
module "codebuild_role"{
  source= "./../iam_roles/aws-codepipeline-lab-codebuild-role"
}
resource "aws_codebuild_project" "aws-codepipeline-lab-codebuild-project" {
  name          = "aws-codepipeline-lab-codebuild-project"
  description   = ""
  build_timeout = 100
  service_role  = module.codebuild_role.codebuild_role_arn

  artifacts {
    type = "S3"
    name = local.s3_name
    location=local.s3_name
  }


  source {
    type            = "GITHUB"
    location        = "<YOUR_GITHUB_REPO_URL_HERE>"
    git_clone_depth = 1
      buildspec       = "buildspec.yml"
  }

  source_version = "master"
    environment {
    compute_type                = "BUILD_GENERAL1_SMALL"
    image                       = "aws/codebuild/amazonlinux2-x86_64-standard:5.0"
    type                        = "LINUX_CONTAINER"
    image_pull_credentials_type = "CODEBUILD"

  }

  cache {
    type = "NO_CACHE"
  }

}