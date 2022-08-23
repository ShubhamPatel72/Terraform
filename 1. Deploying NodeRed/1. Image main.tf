
  terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      // define all the req provider here and their sources
    }
  }
}

provider "docker" {
  host = "unix:///var/run/docker.sock"
}
// use terraform.io/docs/providers for syntax and more providers

resource "docker_image" "Nodered"{
    name = "nodered/node-red:latest"
    //This is an actual name of image, we can find it in docker hub
}
