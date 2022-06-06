provider "aws" {
    region = var.region
    access_key = var.AWS_ACCESS_KEY_ID
    secret_key = var.AWS_SECRET_ACCESS_KEY
}


module "ecrm" {
  source  = "app.terraform.io/witeroo/ecr/aws"
  version = "0.0.1"
  name = var.name
  # insert required variables here
}


# Build Docker image and push to ECR from folder: 
module "ecr_docker_build" {
  source = "github.com/onnimonni/terraform-ecr-docker-build-module"

  # Absolute path into the service which needs to be build
  dockerfile_folder = "${path.module}"

  # Tag for the builded Docker image (Defaults to 'latest')
  docker_image_tag = "latest"

  # ECR repository where we can push
  ecr_repository_url = "${aws_ecr_repository.this.repository_url}"
}