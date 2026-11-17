# Grafana and Prometheus Monitoring Setup on AWS EC2

## Project Overview

This project demonstrates the installation and configuration of **Prometheus and Grafana** on an AWS EC2 instance for infrastructure monitoring and metrics visualization.

- **Prometheus:** Collects and stores monitoring metrics.
- **Grafana:** Visualizes metrics through dashboards.
- **AWS EC2:** Hosts Prometheus and Grafana services.

## Architecture

```text
             AWS EC2 Instance
             (Amazon Linux)
                    |
          +---------+---------+
          |                   |
     Prometheus             Grafana
      Port 9090             Port 3000
          |                   |
          +---------+---------+
                    |
             Data Source
              Integration
                    |
             Grafana Dashboard
```

## 1. Launch AWS EC2 Instance

1. Login to AWS Management Console.
2. Navigate to EC2 and launch an instance.
3. Select Amazon Linux AMI.
4. Choose an appropriate instance type.
5. Configure the security group.

### Security Group Configuration

| Type | Port | Purpose |
|---|---:|---|
| SSH | 22 | EC2 server access |
| Custom TCP | 3000 | Grafana Web UI |
| Custom TCP | 9090 | Prometheus Web UI |

**Security Note:** For production environments, restrict ports 3000 and 9090 to trusted IP addresses. Avoid exposing monitoring interfaces publicly.

## 2. Update EC2 Instance

Connect to your EC2 instance using SSH.

```bash
sudo yum update -y
```

## 3. Install Grafana

Download and install Grafana Enterprise RPM.

```bash
sudo yum install -y https://dl.grafana.com/grafana-enterprise/release/13.3.1/grafana-enterprise_13.3.1_42849527790_linux_amd64.rpm
```

### Verify Grafana Installation

```bash
grafana-server --version
```

### Start Grafana Service

```bash
sudo systemctl start grafana-server
sudo systemctl enable grafana-server
```

### Check Grafana Status

```bash
sudo systemctl status grafana-server
```

### Access Grafana Dashboard

Open the following URL in your browser:

```text
http://<EC2-PUBLIC-IP>:3000
```

**Default Login Credentials:**

- Username: `admin`
- Password: `admin`

Change the default password after your first login.

## 4. Install Prometheus

Download Prometheus version 3.16.0.

```bash
wget -q https://github.com/prometheus/prometheus/releases/download/v3.16.0/prometheus-3.16.0.linux-amd64.tar.gz
```

### Verify Download

```bash
ls
```

### Extract Prometheus Archive

```bash
sudo tar -xzf prometheus-3.16.0.linux-amd64.tar.gz
```

### Navigate to Prometheus Directory

```bash
cd prometheus-3.16.0.linux-amd64/
```

### Verify Prometheus Files

```bash
ls
```

### Check Prometheus Version

```bash
./prometheus --version
```

## 5. Configure Prometheus Data Directory

Create a directory to store Prometheus data.

```bash
sudo mkdir -p data
```

Assign ownership to the EC2 user.

```bash
sudo chown -R ec2-user:ec2-user data
```

Set directory permissions.

```bash
chmod 755 data
```

## 6. Start Prometheus

Run Prometheus using the following command:

```bash
./prometheus
```

Prometheus starts using its default configuration file (`prometheus.yml`) and listens on port `9090`.

**Note:** Keep the terminal session running while using this command. For a persistent production setup, configure Prometheus as a systemd service.

### Access Prometheus Web UI

Open the following URL:

```text
http://<EC2-PUBLIC-IP>:9090
```

## 7. Integrate Prometheus with Grafana

Follow these steps to configure Prometheus as a Grafana data source.

1. Login to Grafana.

   ```text
   http://<EC2-PUBLIC-IP>:3000
   ```

2. Navigate to **Connections → Data Sources**.
3. Click **Add data source**.
4. Select **Prometheus**.
5. Enter the Prometheus server URL:

   ```text
   http://localhost:9090
   ```

6. Click **Save & Test**.

If the configuration is correct, Grafana will successfully connect to Prometheus.

**Important:** `localhost` works because both Grafana and Prometheus are running on the same EC2 instance.

## 8. Useful Commands

### Grafana Commands

```bash
# Check version
grafana-server --version

# Start Grafana
sudo systemctl start grafana-server

# Stop Grafana
sudo systemctl stop grafana-server

# Restart Grafana
sudo systemctl restart grafana-server

# Enable Grafana at boot
sudo systemctl enable grafana-server

# Check service status
sudo systemctl status grafana-server
```

### Prometheus Commands

```bash
# Check version
./prometheus --version

# Start Prometheus
./prometheus

# Check listening port
sudo ss -tulnp | grep 9090
```

## 9. Project URLs

| Application | URL |
|---|---|
| Grafana | `http://<EC2-PUBLIC-IP>:3000` |
| Prometheus | `http://<EC2-PUBLIC-IP>:9090` |

## 10. Technologies Used

- AWS EC2
- Amazon Linux
- Prometheus 3.16.0
- Grafana Enterprise 13.3.1
- Linux Commands
- Systemd Services
- Infrastructure Monitoring

## 11. Learning Outcomes

Through this project, I learned:

- How to launch and configure AWS EC2 instances.
- How to install and configure Grafana.
- How to install and run Prometheus.
- How to manage Linux services using systemctl.
- How to configure AWS Security Groups.
- How to integrate Prometheus with Grafana.
- How to connect a monitoring data source to Grafana.

## Conclusion

Successfully installed Prometheus and Grafana on AWS EC2 and integrated Prometheus as a Grafana data source.

This project provides hands-on experience with infrastructure monitoring, metrics collection, and dashboard visualization, which are important concepts in DevOps and Site Reliability Engineering (SRE).
