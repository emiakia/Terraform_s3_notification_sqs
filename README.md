# Terraform AWS S3 and SQS Notification Project

## Overview

This Terraform project sets up an AWS S3 bucket with various configurations and an SQS queue to handle notifications. Specifically, it configures the following:

- An S3 bucket with versioning and server-side encryption.
- Public access block settings for the S3 bucket.
- An SQS queue to receive notifications.
- SQS queue policy to allow S3 bucket to send messages to the queue.
- S3 bucket notification configuration to send notifications for object creation and deletion events to the SQS queue.

## Modules

### 1. `aws_s3_bucket`

This module creates an S3 bucket. You can specify the bucket name and other optional parameters.

- **Source Directory:** `./modules/aws_s3_bucket`
- **Inputs:**
  - `s3b_bucket_name`: The name of the S3 bucket.

### 2. `aws_s3_bucket_versioning`

This module enables or disables versioning for the S3 bucket.

- **Source Directory:** `./modules/aws_s3_bucket_versioning`
- **Inputs:**
  - `s3bv_bucket`: The ID of the S3 bucket to configure versioning.
  - `s3bv_status`: The status of versioning (Enabled/Disabled).

### 3. `aws_s3_bucket_encryption`

This module sets up server-side encryption for the S3 bucket, allowing you to specify encryption algorithms and bucket key settings.

- **Source Directory:** `./modules/aws_s3_bucket_encryption`
- **Inputs:**
  - `s3bse_bucket`: The ID of the S3 bucket to configure encryption.
  - `s3bse_sse_algorithm`: The encryption algorithm (e.g., AES256).
  - `s3bse_bucket_key_enabled`: Boolean to enable or disable bucket key usage.

### 4. `aws_s3_bucket_public_access_block`

This module configures public access block settings for the S3 bucket to prevent or allow public access.

- **Source Directory:** `./modules/aws_s3_bucket_public_access_block`
- **Inputs:**
  - `s3bpab_bucket`: The ID of the S3 bucket to configure public access settings.
  - `s3bpab_block_public_acls`: Boolean to block public ACLs.
  - `s3bpab_block_public_policy`: Boolean to block public policies.

### 5. `aws_sqs_queue`

This module creates an SQS queue to receive notifications.

- **Source Directory:** `./modules/aws_sqs_queue`
- **Inputs:**
  - `sqsq_name`: The name of the SQS queue.

### 6. `aws_sqs_queue_policy`

This module creates a policy for the SQS queue to allow the S3 bucket to send messages to it.

- **Source Directory:** `./modules/aws_sqs_queue_policy`
- **Inputs:**
  - `sqsqp_queue_url`: The URL of the SQS queue.
  - `sqsqp_policy`: The JSON policy that allows S3 to send messages.

### 7. `aws_s3_bucket_notification`

This module configures S3 bucket notifications to send events to the SQS queue.

- **Source Directory:** `./modules/aws_s3_bucket_notification`
- **Inputs:**
  - `s3bkn_bucket_id`: The ID of the S3 bucket.
  - `s3bkn_queue_arn`: The ARN of the SQS queue.
  - `s3bkn_events`: A list of events to trigger notifications (e.g., `s3:ObjectCreated:*`, `s3:ObjectRemoved:*`).
  - `s3bkn_topic_arn`: Optional SNS topic ARN for additional notifications (commented out in the current configuration).

## Usage

1. **Initialize Terraform:**

   ```bash
   terraform init
