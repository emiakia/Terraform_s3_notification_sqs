provider "aws" {
  region = "eu-central-1"  # Change to your preferred region
}

module "s3_bucket" {
  source      = "./modules/aws_s3_bucket"
  s3b_bucket_name = var.s3b_bucket_name
}



# resource "aws_s3_bucket" "emrankia" {
#   bucket = "emrankiaterraform"
# }

module "s3_bucket_versioning" {
  source      = "./modules/aws_s3_bucket_versioning"
  s3bv_bucket = module.s3_bucket.bucket_id
  s3bv_status = "Enabled"  # You can change this value to "Disabled" if desired
}


# resource "aws_s3_bucket_versioning" "versioning_example" {
#   bucket = module.s3_bucket.id
#   versioning_configuration {
#     status = "Disabled"
#   }
# }

module "s3_bucket_encryption" {
  source                 = "./modules/aws_s3_bucket_encryption"
  s3bse_bucket           = module.s3_bucket.bucket_id
  s3bse_sse_algorithm    = var.s3bse_sse_algorithm  # Optional, uses default value if not set
  s3bse_bucket_key_enabled = var.s3bse_bucket_key_enabled  # Optional, uses default value if not set
}

# resource "aws_s3_bucket_server_side_encryption_configuration" "example" {
#   bucket = module.s3_bucket.bucket_id

#   rule {
#     apply_server_side_encryption_by_default {
#       sse_algorithm     = "AES256"  # SSE-S3 for Amazon S3-managed keys
#     }
#     bucket_key_enabled = true  # Enable Bucket Key
#   }
# }
module "s3_bucket_public_access_block" {
  source                 = "./modules/aws_s3_bucket_public_access_block"
  s3bpab_bucket          = module.s3_bucket.bucket_id
  s3bpab_block_public_acls   = var.s3bpab_block_public_acls   # Optional, uses default value if not set
  s3bpab_block_public_policy = var.s3bpab_block_public_policy # Optional, uses default value if not set
}

# resource "aws_s3_bucket_public_access_block" "emrankia" {
#   bucket = module.s3_bucket.bucket_bucket

#   block_public_acls   = false
#   block_public_policy = false
# }

###########################################################################################
###########################################################################################
###########################################################################################


# Create an SQS queue for notifications
module "sqs_queue" {
  source     = "./modules/aws_sqs_queue"
  sqsq_name  = var.sqsq_name
}
# resource "aws_sqs_queue" "sqs_notification" {
#   name = "sqs_notification"
# }

# Add SQS queue policy to allow S3 to send messages

module "sqs_queue_policy" {
  source        = "./modules/aws_sqs_queue_policy"
  sqsqp_queue_url = module.sqs_queue.sqs_queue_url
  sqsqp_policy   = <<POLICY
{
  "Version": "2012-10-17",
  "Id": "sqs_notificationPolicy",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": "*",
      "Action": "sqs:SendMessage",
      "Resource": "${module.sqs_queue.sqs_queue_arn}",
      "Condition": {
        "ArnEquals": {
          "aws:SourceArn": "${module.s3_bucket.bucket_arn}"
        }
      }
    }
  ]
}
POLICY
}

# resource "aws_sqs_queue_policy" "sqs_notification_policy" {
#   queue_url = module.sqs_queue.sqs_queue_id

#   policy = <<POLICY
# {
#   "Version": "2012-10-17",
#   "Id": "sqs_notificationPolicy",
#   "Statement": [
#     {
#       "Effect": "Allow",
#       "Principal": "*",
#       "Action": "sqs:SendMessage",
#       "Resource": "${module.sqs_queue.sqs_queue_arn}",
#       "Condition": {
#         "ArnEquals": {
#           "aws:SourceArn": "${module.s3_bucket.bucket_arn}"
#         }
#       }
#     }
#   ]
# }
# POLICY
# }


###########################################################################################
###########################################################################################
###########################################################################################



# Create an S3 bucket notification to trigger both SNS and SQS on object creation events
module "s3_bucket_notification" {
  source        = "./modules/aws_s3_bucket_notification"
  s3bkn_bucket_id  = module.s3_bucket.bucket_id
  s3bkn_queue_arn  = module.sqs_queue.sqs_queue_arn
  s3bkn_events     = ["s3:ObjectCreated:*", "s3:ObjectRemoved:*"]
  s3bkn_topic_arn  = ""  # Optional, if you use SNS topic uncomment and set
  # s3bkn_depends_on = [module.sqs_queue_policy]  # Optional, include other dependencies as needed
}


# resource "aws_s3_bucket_notification" "emrankia_notification" {
#   bucket = module.s3_bucket.bucket_id

#   queue {
#     queue_arn = module.sqs_queue.sqs_queue_arn
#     events    = ["s3:ObjectCreated:*", "s3:ObjectRemoved:*"]
#   }

#   # topic {
#   #   topic_arn = aws_sns_topic.sns_notification.arn
#   #   events    = ["s3:ObjectCreated:*", "s3:ObjectRemoved:*"]
#   # }

#   depends_on = [
#     module.sqs_queue_policy,
#     # aws_sns_topic_policy.sns_notification_policy
#   ]
# }