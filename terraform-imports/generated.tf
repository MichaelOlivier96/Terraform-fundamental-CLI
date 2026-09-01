# __generated__ by Terraform
# Please review these resources and move them into your main configuration files.

# __generated__ by Terraform from "2ee78add8af6d0c88a071fd89b58d50c3f70c9f49272ac3757339d33a870005c"
resource "docker_container" "web" {
  image = "docker_image.nginx.latest"
  name  = "hashicorp-learn"
  env   = []
  ports {
    external = 8081
    internal = 80
    ip       = "0.0.0.0"
    protocol = "tcp"
  }
}
