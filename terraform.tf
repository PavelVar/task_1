provider "aws" {
	access_key = "AKIAYUV3MY7THKW7VIG5"
	secret_key = "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"
	region = var.aws_region
}

resource "aws_instance" "task_1_varyvonchyk" {
	key_name              = "vp_aws_key"
	ami                    = var.ami
	instance_type          = var.instance_type
	
	security_groups        = [aws_security_group.SG_task_1_varyvonchyk.name]
		
	user_data              = file(var.user_data)
	
	tags                   = var.tag

	ebs_block_device {
		delete_on_termination = true
		volume_size           = 8
		volume_type           = var.default_ebs_volume_type
		device_name           = var.device_name
        tags                  = {
			Name = "onboarding_qa_varyvonchyk_p_data_volume"
		}
	}
		
	root_block_device {
		delete_on_termination = true
		volume_size           = 12
		volume_type           = var.default_ebs_volume_type
		tags                  = var.tag
	}
}		

resource "aws_network_interface" "network" {
	subnet_id       = aws_instance.task_1_varyvonchyk.subnet_id

	attachment {
		instance     = aws_instance.task_1_varyvonchyk.id
		device_index = 1
	}

	tags = var.tag
}


resource "aws_security_group" "SG_task_1_varyvonchyk" {
	name        = "task_1_varyvonchyk"
	description = "Allow task_1_varyvonchyk traffic"
     
	egress {
		description      = "Security Group rule 1: Allow all outgoing traffic for any protocol"
		from_port        = 0
		to_port          = 0
		protocol         = "-1"
		cidr_blocks      = ["0.0.0.0/0"]
		ipv6_cidr_blocks = ["::/0"]
	}
	
	dynamic "ingress" {
		for_each = var.allowed_ports
		content {
			description      = "Allow SSH incoming traffic from anywhere for port ingress.value"
			from_port        = ingress.value
			to_port          = ingress.value
			protocol         = "tcp"
			cidr_blocks      = ["0.0.0.0/0"]
			ipv6_cidr_blocks = ["::/0"]
		}
	}
	
	tags = var.tag
}
