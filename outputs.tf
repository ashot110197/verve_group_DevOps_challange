### The Ansible inventory file
resource "local_file" "AnsibleInventory" {
 filename     = "hosts"
 content      = templatefile ("inventory.tmpl",
 {
    public-ip = "${aws_instance.ruby_instance.public_ip}"
 }
 )
}

output "lb_pub_dns" {
   value      = aws_lb.web_app.dns_name
}