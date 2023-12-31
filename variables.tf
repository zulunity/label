###
# Standard Variables
#
# All modules expect these variables to be defined. Omitting them will result in errors or undefined/undesirable behavior.
#
variable "account" {
  type        = string
  default     = null
  description = "Name of the account being used (master, nonprod, prod, etc)"
}

variable "additional_tag_map" {
  type        = map(string)
  default     = {}
  description = "Additional tags for appending to tags_as_list_of_maps. Not added to `tags`."
}

variable "attributes" {
  type        = list(string)
  default     = []
  description = "Additional attributes (e.g. `1`)"
}

variable "cloud_provider" {
  type        = string
  default     = null
  description = "Cloud provider name if any"
}

variable "context" {
  type = object({
    enabled             = bool
    namespace           = string
    cloud_provider      = string
    account             = string
    region              = string
    environment         = string
    stage               = string
    domain              = string
    name                = string
    delimiter           = string
    attributes          = list(string)
    tags                = map(string)
    additional_tag_map  = map(string)
    regex_replace_chars = string
    label_order         = list(string)
    id_length_limit     = number
  })
  default = {
    enabled             = true
    namespace           = null
    cloud_provider      = null
    account             = null
    region              = null
    environment         = null
    stage               = null
    domain              = null
    name                = null
    delimiter           = null
    attributes          = []
    tags                = {}
    additional_tag_map  = {}
    regex_replace_chars = null
    label_order         = []
    id_length_limit     = null
  }
  description = <<-EOT
    Single object for setting entire context at once.
    See description of individual variables for details.
    Leave string and numeric variables as `null` to use default value.
    Individual variable settings (non-null) override settings in context object,
    except for attributes, tags, and additional_tag_map, which are merged.
  EOT
}

variable "delimiter" {
  type        = string
  default     = null
  description = <<-EOT
    Delimiter to be used between `namespace`, `environment`, `stage`, `name` and `attributes`.
    Defaults to `-` (hyphen). Set to `""` to use no delimiter at all.
  EOT
}

variable "domain" {
  type        = string
  default     = null
  description = "TLD to use when deploying assets"
}

variable "enabled" {
  type        = bool
  default     = true
  description = "Set to false to prevent the module from creating any resources"
}

variable "environment" {
  type        = string
  default     = null
  description = "Environment, e.g. 'prod', 'staging', 'dev', 'pre-prod', 'UAT'"
}

variable "id_length_limit" {
  type        = number
  default     = null
  description = <<-EOT
    Limit `id` to this many characters.
    Set to `0` for unlimited length.
    Set to `null` for default, which is `0`.
    Does not affect `id_full`.
  EOT
}

variable "label_key_case" {
  type        = string
  default     = null
  description = <<-EOT
    Controls the letter case of the `tags` keys (label names) for tags generated by this module.
    Does not affect keys of tags passed in via the `tags` input.
    Possible values: `lower`, `title`, `upper`.
    Default value: `title`.
  EOT

  validation {
    condition     = var.label_key_case == null ? true : contains(["lower", "title", "upper"], var.label_key_case)
    error_message = "Allowed values: `lower`, `title`, `upper`."
  }
}

variable "label_order" {
  type        = list(string)
  default     = null
  description = <<-EOT
    The naming order of the id output and Name tag.
    Defaults to ["namespace", "environment", "stage", "name", "attributes"].
    You can omit any of the 5 elements, but at least one must be present.
  EOT
}

variable "label_value_case" {
  type        = string
  default     = null
  description = <<-EOT
    Controls the letter case of ID elements (labels) as included in `id`,
    set as tag values, and output by this module individually.
    Does not affect values of tags passed in via the `tags` input.
    Possible values: `lower`, `title`, `upper` and `none` (no transformation).
    Set this to `title` and set `delimiter` to `""` to yield Pascal Case IDs.
    Default value: `lower`.
  EOT

  validation {
    condition     = var.label_value_case == null ? true : contains(["lower", "title", "upper", "none"], var.label_value_case)
    error_message = "Allowed values: `lower`, `title`, `upper`, `none`."
  }
}

variable "name" {
  type        = string
  default     = null
  description = "Module name, e.g. 'app' or 'jenkins'"
}

variable "namespace" {
  type        = string
  default     = null
  description = "Namespace, which could be your organization name or abbreviation, e.g. 'eg' or 'cp'"
}

variable "regex_replace_chars" {
  type        = string
  default     = null
  description = <<-EOT
    Regex to replace chars with empty string in `namespace`, `environment`, `stage` and `name`.
    If not set, `"/[^a-zA-Z0-9-]/"` is used to remove all characters other than hyphens, letters and digits.
  EOT
}

variable "region" {
  type        = string
  default     = null
  description = "AWS region to deploy asset into"
}

variable "stage" {
  type        = string
  default     = null
  description = "Stage, e.g. 'prod', 'staging', 'dev', OR 'source', 'build', 'test', 'deploy', 'release'"
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Additional tags (e.g. `map('BusinessUnit','XYZ')`"
}
