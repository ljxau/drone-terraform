data "template_file" "drone_agent_task_definition" {
  template = "${file("task-definitions/drone-agent.json")}"

  vars {
    log_group_region      = "${var.aws_region}"
    log_group_drone_agent = "${aws_cloudwatch_log_group.drone_agent.name}"
    drone_server          = "${aws_route53_record.drone.fqdn}"
  }
}

resource "aws_ecs_task_definition" "drone_agent" {
  family                = "drone-agent"
  container_definitions = "${data.template_file.drone_agent_task_definition.rendered}"

  volume {
    name      = "dockersock"
    host_path = "/var/run/docker.sock"
  }
}

resource "aws_ecs_service" "drone_agent" {
  name            = "drone-agent"
  cluster         = "${aws_ecs_cluster.drone.id}"
  desired_count   = 2
  task_definition = "${aws_ecs_task_definition.drone_agent.arn}"
}