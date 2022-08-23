

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

    image = docker_image.Nodered_img.latest

    ports {
        internal = 1880

        //external = 1880

    }
}

// A splat expression provides a more concise way to express a common operation that could 
// otherwise be performed with a for expression.

// here in ouput, we can use splat expression which give us list

output "Container-name" {
    value = docker_container.Nodered_cont[*].name
    description = "The Name of the container"
}

# output:
#  Container-name = [
#  "nodered-zmy2",
#  "nodered-ffb5",
#]




