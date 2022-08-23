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


resource "random_string" "random" {
    count = 2
    // we dont need to write multiple time for mulitple resource, data and module
    // it generate 2 random string like random[0], random[1]

    length = 4
    special = false
    upper = false
}




resource "docker_image" "Nodered_img"{
    name = "nodered/node-red:latest"

}

resource "docker_container" "Nodered_cont" {
    count = 2
    name = join("-", ["nodered", random_string.random[count.index].id])
    // can't assign any index to name it produce similar name
    // have to use count.index here

    image = docker_image.Nodered_img.latest

    ports {
        internal = 1880

        //external = 1880

    }
}



output "Container-1-name" {
    value = docker_container.Nodered_cont[0].name
    description = "The Name of the container"
}

// Can't use count.index in output as it give error

output "Container-2-name" {
    value = docker_container.Nodered_cont[1].name
    description = "The Name of the container"
}

