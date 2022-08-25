

// previous count main.tf file


//The name of a variable can be any valid identifier except the following: 
//  source, version, providers, count, for_each, lifecycle, depends_on, locals.
variable ext_port {
  type        = number
  default     = 1880
  description = "description"
}

// Inside container resource
resource "docker_container" "Nodered_cont" {
    name = nodered

    ports {
        internal = 1880

        external = var.ext_port

    }
}

// it ask for value of ext_port whenever we plan, apply or destroy resources if there is no default
// we can use "terraform plan -var=1920"


# we can also use Environment Variables
// command:
//  export TF_VAR_name-of-varibale=value
//  export TF_VAR_ext_port = 1920
//  terraform plan

