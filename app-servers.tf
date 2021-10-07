resource "aws_key_pair" "ec2key" {
  key_name               = "publicKey"
  public_key             = file(var.public_key_path)
}

resource "aws_instance" "ruby_instance" {
  ami                    = var.instance_ami
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.subnet_public.id
  key_name               = aws_key_pair.ec2key.key_name
  vpc_security_group_ids = [aws_security_group.web_app_sg.id]

  tags = {
		"Environment"        = var.environment_tag
	}
}