output "key_pair_name" {
  value = aws_key_pair.assignment4_key.key_name
}


output "key_pair_private_key" {
  value       = aws_key_pair.assignment4_key.key_name
  description = "Private key material. Save it securely!"
}

output "key_pair_public_key" {
  value = aws_key_pair.assignment4_key.public_key
}
