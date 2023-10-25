terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0"
    }
    # docker = {
    #   source  = "kreuzwerker/docker"
    #   version = "2.16.0"
    # }
    # helm = {
    #   source  = "hashicorp/helm"
    #   version = "2.5.1"
    # }
    # kubernetes = {
    #   source  = "hashicorp/kubernetes"
    #   version = "2.16.0"
    # }
    # tls = {
    #   source  = "hashicorp/tls"
    #   version = "3.3.0"
    # }
    # null = {
    #   source  = "hashicorp/null"
    #   version = "3.1.1"
    # }
    # random = {
    #   source  = "hashicorp/random"
    #   version = "3.1.3"
    # }
  }
  required_version = ">= 1.3.2"
}