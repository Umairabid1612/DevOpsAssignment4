resource "aws_key_pair" "assignment4_key" {
  key_name   = "cs423-assignment4-key"
  public_key = file("~/.ssh/cs423-assignment4-key.pub")
}

data "aws_key_pair" "assignment4_key_data" {
  key_name = aws_key_pair.assignment4_key.key_name
}
