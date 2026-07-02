resource "aws_ecr_repository" "this" {
  name                 = var.repository_name
  image_tag_mutability = var.image_tag_mutability
  force_delete         = var.force_delete

  image_scanning_configuration {
    scan_on_push = var.scan_on_push
  }

  encryption_configuration {
    encryption_type = var.encryption_type
    kms_key         = var.encryption_type == "KMS" ? var.kms_key : null
  }

  tags = merge(
    var.tags,
    {
      Name = var.repository_name
    }
  )
}

resource "aws_ecr_lifecycle_policy" "this" {
  count = var.lifecycle_policy_enabled ? 1 : 0

  repository = aws_ecr_repository.this.name

  policy = jsonencode({
    rules = [
      {
        rulePriority = 1
        description  = "Expire untagged images"

        selection = {
          tagStatus   = "untagged"
          countType   = "imageCountMoreThan"
          countNumber = var.untagged_image_retention
        }

        action = {
          type = "expire"
        }
      },
      {
        rulePriority = 2
        description  = "Retain recent images"

        selection = {
          tagStatus   = "any"
          countType   = "imageCountMoreThan"
          countNumber = var.tagged_image_retention
        }

        action = {
          type = "expire"
        }
      }
    ]
  })
}