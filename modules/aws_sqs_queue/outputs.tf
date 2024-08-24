output "sqs_queue_id" {
  description = "The ID of the SQS queue."
  value       = aws_sqs_queue.this.id
}

output "sqs_queue_name" {
  description = "The name of the SQS queue."
  value       = aws_sqs_queue.this.name
}

output "sqs_queue_arn" {
  description = "The ARN of the SQS queue."
  value       = aws_sqs_queue.this.arn
}

output "sqs_queue_url" {
  description = "The URL of the SQS queue."
  value       = aws_sqs_queue.this.url
}
