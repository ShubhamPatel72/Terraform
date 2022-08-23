// join function and output module in previous folder

terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"

    }
  }
}

provider "docker" {
  host = "unix:///var/run/docker.sock"
}

// Main function of random_string is to generate random string of given length
// special and upper are default true
// for more search "terraform random provider"
resource "random_string" "random1" {
    length = 4
    special = false
    upper = false
}

resource "random_string" "random2" {
    length = 4
    special = false
    upper = false
}


resource "docker_image" "Nodered_img"{
    name = "nodered/node-red:latest"

}

resource "docker_container" "Nodered_cont1" {
    name = join("-", ["nodered", random_string.random1.id])

    image = docker_image.Nodered_img.latest

    ports {
        internal = 1880

        //external = 1880

    }
}

resource "docker_container" "Nodered_cont2" {
    name = join("-", ["nodered", random_string.random2.id])

    image = docker_image.Nodered_img.latest

    ports {
        internal = 1880

        //external = 1880

    }
}

output "Container-1-name" {
    value = docker_container.Nodered_cont1.name
    description = "The Name of the container"
}

output "Container-2-name" {
    value = docker_container.Nodered_cont2.name
    description = "The Name of the container"
}

