provider "aws" {
  region = var.aws_region
}

provider "kubernetes" {
  host = data.terraform_remote_state.dev.outputs.cluster_endpoint

  cluster_ca_certificate = base64decode(
    data.terraform_remote_state.dev.outputs.cluster_certificate_authority_data
  )

  exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    command     = "aws"

    args = [
      "eks",
      "get-token",
      "--region",
      var.aws_region,
      "--cluster-name",
      data.terraform_remote_state.dev.outputs.cluster_name
    ]
  }
}

provider "helm" {
  kubernetes = {
    host = data.terraform_remote_state.dev.outputs.cluster_endpoint

    cluster_ca_certificate = base64decode(
      data.terraform_remote_state.dev.outputs.cluster_certificate_authority_data
    )

    exec = {
      api_version = "client.authentication.k8s.io/v1beta1"
      command     = "aws"

      args = [
        "eks",
        "get-token",
        "--region",
        var.aws_region,
        "--cluster-name",
        data.terraform_remote_state.dev.outputs.cluster_name
      ]
    }
  }
}