output "control_plane_ip" {
    value = aws_instance.control_plane.public_ip
}

output "test_worker_ip" {
    value = aws_instance.test_worker.public_ip
}

output "prod_worker_ip" {
    value = aws_instance.prod_worker.public_ip
}

