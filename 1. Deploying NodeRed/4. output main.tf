
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

resource "docker_image" "Nodered_img"{
    name = "nodered/node-red:latest"
    //This is an actual name of image, we can find it in docker hub
}

resource "docker_container" "Nodered_cont" {
    name = "nodered"
    // user define name
    image = docker_image.Nodered_img.latest

    ports {
        internal = 1880
        // internal port for node red is 1880
        external = 1880
        // external can be different.
    }
}

//we can check if container is deploy with "docker ps"
//site with "public ip:1880"


// name of output is used to identify and this name is displayed to the user
// In a child module, it can be used to access the output's value.
output "IP-Address" {
    value = docker_container.Nodered_cont.ip_address
    description = "The IP address of the container"
}

//In console output is like
// IP-Address = 172.172.1.2

//we can directly see the output using terraform out