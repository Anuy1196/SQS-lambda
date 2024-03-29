resource "aws_sqs_queue" "terraform_queue_deadletter" {
  name = "terraform-queue-deadletter"
  # Other configuration options for the dead-letter queue
}

resource "aws_sqs_queue" "some_queue" {
  name = "SomeQueue"
  delay_seconds             = 90
  max_message_size          = 2048
  message_retention_seconds = 86400
  receive_wait_time_seconds = 10
  redrive_policy   = jsonencode({
  deadLetterTargetArn = aws_sqs_queue.terraform_queue_deadletter.arn
  maxReceiveCount     = 4
  })
}