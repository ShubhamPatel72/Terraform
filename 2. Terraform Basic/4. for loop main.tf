

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

output "Container-name" {
    value = docker_container.Nodered_cont[*].name
    description = "The Name of the container"
}

# for output of Ip-address:external port we can't just splat expression
# as it compute Ip-address first and then ports
# it gives error and if forcefully flattens used it shows result like this
# 172.12.1.2:172,.12.3.2:1890:1029

// To correctly print Ip-address:external port 
// we will use for loop

output "Ip-address" {
    value = [ for i in docker_container.Nodered_cont[*]: join(":", [i.ip_address], i.ports[*]["external"])]
    description = "Ip-address: external port"
}


#output:
#Ip-address = [
#  "172.17.0.3:49160",
#  "172.17.0.2:49159",
#]




