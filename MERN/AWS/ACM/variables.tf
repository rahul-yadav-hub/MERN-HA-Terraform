variable "subdomain_name" {
  description = "Value of the subdomain"
  type        = string
}

variable "hosted_zone_name" {
  description = "Value of the record type"
  type        = string

}

variable "count_value" {
  description = " value to generate certificate using ACM for ALB"
  type = bool
}