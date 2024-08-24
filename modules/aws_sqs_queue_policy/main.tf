resource "aws_sqs_queue_policy" "this" {
  queue_url = var.sqsqp_queue_url

  policy = var.sqsqp_policy
}
