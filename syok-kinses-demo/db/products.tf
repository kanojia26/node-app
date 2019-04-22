resource "aws_dynamodb_table" "products" {
  name           = "${var.application}-products"
  read_capacity  = 5
  write_capacity = 5
  hash_key       = "sn"

  attribute {
    name = "sn"
    type = "S"
  }
}
