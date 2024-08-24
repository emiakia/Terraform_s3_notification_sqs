variable "sqsqp_queue_url" {
  description = "The URL of the SQS queue to attach the policy to."
  type        = string
}

variable "sqsqp_policy" {
  description = "The policy JSON to apply to the SQS queue."
  type        = string
}
