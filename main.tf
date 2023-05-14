provider "aws" {
  region = "us-west-2"
}

module "vpc" {
  source = "./vpc"
}

module "s3" {
  source = "./s3"
  bucket_name = "leandro-teste-strada-state-bucket"
}

module "rds" {
  source = "./rds"
}

module "eks" {
  source = "./eks"
}

module "application" {
  source = "./application"
  eks_cluster_name = module.eks.my_eks_cluster_name
}