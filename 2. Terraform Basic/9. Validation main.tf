
// You can specify custom validation rules for a particular variable by adding a validation block 
// within the corresponding variable block. 
// example

variable "image_id" {
  type        = string
  description = "The id of the machine image (AMI) to use for the server."

  validation {
    condition     = length(var.image_id) > 4 && substr(var.image_id, 0, 4) == "ami-"
    error_message = "The image_id value must be a valid AMI id, starting with \"ami-\"."
  }
}

variable ext_port {
  type        = number
  default     = 1880
  description = "external port"
    validation {
        condition = var.ext_port == 1880
        error_message = "The external port should be 1880."
        // Must start error mssg with upper case letter and end with period(.)
    }
    // If ext_port is not 1880 then error mssg display on screen

}