variable "subdomain_name" {
  description = "Value of the subdomain"
  type        = string
}
variable "record_type" {
  description = "Value of the record type"
  type        = string
  default = "A"
}

variable "hosted_zone_name" {
  description = "Value of the record type"
  type        = string
  default = "squareops.co.in"
}

variable "record" {
  description = "Value of the record"
  type        = string
}
variable "resource_zone_id" {
  description = "Value of the resrouce zone ID"
  type        = string
}

variable "count_value" {
  description = "Value of the count whether to craete or not"
  type        = string
}



