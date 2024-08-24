output "sqs_queue_policy_id" {
  description = "The ID of the SQS queue policy."
  value       = aws_sqs_queue_policy.this.id
}
