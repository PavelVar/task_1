
variable "aws_region" {
    type = string
    default = "eu-central-1"
}

variable "key_name" {
	type    = string
	default = "vp_aws_key"
}

variable "ami" {
	type    = string
	default = "ami-047e03b8591f2d48a"
}

variable "instance_type" {
	type    = string
	default = "t2.micro"
}

variable "user_data" {
	type    = string
	default = "/home/pavel/PycharmProjects/t1/flask_script.sh"
}

variable "default_ebs_volume_type" {
	type    = string
	default = "gp2"
}

variable "device_name" {
	type    = string
	default = "/dev/sda2"
}

variable "allowed_ports" {
	type    = list
	default = ["22", "5000"]
}

variable "tag" {
	type    = map
	default = {
	Name = "onboarding_qa_varyvonchyk_p_instance"
	}
}
