
// very similar to one in py
// join(separator, list)

// > join(", ", ["foo", "bar", "baz"])
//   foo, bar, baz
//> join(", ", ["foo"])
//   foo


  // just add previous output main.tf here

output "IP-Deployed-Nodered" {
    value = join(":", [docker_container.Nodered_cont.ip_address, docker_container.Nodered_cont.ports[0].external])
    // AS ports is list of different ports we used
    // here we join container's (private) ip address and external port that we defined in container main.tf

    description = "private ip address : external port"
  }