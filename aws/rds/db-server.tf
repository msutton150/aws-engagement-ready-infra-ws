resource "aws_db_instance" "my-database" {
  allocated_storage          = 20
  storage_type               = "gp2"
  engine                     = "mysql"
  engine_version             = "8.0"
  auto_minor_version_upgrade = true
  instance_class             = "db.t4g.micro"
  db_name                    = "db_server"
  username                   = "admin"
  password                   = "pa$$w0rd"
  skip_final_snapshot        = true
}
