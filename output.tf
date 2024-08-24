output "bucket_id" {
  value = module.s3_bucket.bucket_id
}

output "bucket_arn" {
  value = module.s3_bucket.bucket_arn
}

output "bucket_versioning_status" {
  value = module.s3_bucket_versioning.versioning_status
}

output "encryption_algorithm" {
  value = module.s3_bucket_encryption.encryption_algorithm
}

output "bucket_key_enabled" {
  value = module.s3_bucket_encryption.bucket_key_enabled
}

output "block_public_acls" {
  value = module.s3_bucket_public_access_block.block_public_acls
}

output "block_public_policy" {
  value = module.s3_bucket_public_access_block.block_public_policy
}

output "sqs_queue_name" {
  value = module.sqs_queue.sqs_queue_name
}

output "sqs_queue_arn" {
  value = module.sqs_queue.sqs_queue_arn
}

output "sqs_queue_url" {
  value = module.sqs_queue.sqs_queue_url
}

output "sqs_queue_policy_id" {
  value = module.sqs_queue_policy.sqs_queue_policy_id
}

output "s3_bucket_notification_id" {
  value = module.s3_bucket_notification.s3_bucket_notification_id
}