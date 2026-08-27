resource "aws_ecs_cluster" "main" {
  name = "threatmod-cluster"
  
  tags = {
    Name    = "threatmod-cluster"
    Project = "ECS-Project"
  }
}

resource "aws_ecs_service" "app" {
  name            = "threatmod-service"
  cluster         = aws_ecs_cluster.main.id  
  task_definition = aws_ecs_task_definition.test.arn  
  desired_count   = 1    
  launch_type     = "FARGATE"
  
  network_configuration {
    subnets         = [aws_subnet.subnettest.id]  
    security_groups = [aws_security_group.ecs_tasks.id]  
    assign_public_ip = true  
  }
    load_balancer {
    target_group_arn = aws_lb_target_group.ecs.arn
    container_name   = "threatmod-container"
    container_port   = 80
  }
}