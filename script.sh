sudo yum update -y
sudo yum install -y https://dl.grafana.com/grafana-enterprise/release/13.3.1/grafana-enterprise_13.3.1_42849527790_linux_amd64.rpm
grafana-server --version
sudo systemctl start grafana-server
sudo systemctl enable grafana-server
sudo wget -q https://github.com/prometheus/prometheus/releases/download/v3.16.0/prometheus-3.16.0.linux-amd64.tar.gz
prometheus --version
ls
sudo tar -xzf prometheus-3.16.0.linux-amd64.tar.gz
ls
cd prometheus-3.16.0.linux-amd64/
ls
sudo chmod +x prometheus
./prometheus
ls -ld .
sudo mkdir -p data
sudo chown -R ec2-user:ec2-user data
chmod 755 data
./prometheus
