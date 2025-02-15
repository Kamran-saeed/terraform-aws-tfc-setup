#!/usr/bin/env bash
set -euo pipefail

function log {
  echo "#########################################################################################################"
  echo $1
  echo "#########################################################################################################"
}

# -----------------------------------------------------------------------------
# Build Docker Image
# -----------------------------------------------------------------------------
echo "cd to hooks directory"
cd ${hooks_directory}
log "Building docker image"
/usr/bin/docker build -f ${docker_file_path}  -t ${image_name}:${image_version} .

# -----------------------------------------------------------------------------
# Replace the variables in docker-compose file
# -----------------------------------------------------------------------------
DOCKER_GROUP=$(getent group docker | cut -d: -f3)
sed -i "s/\$docker_group/$DOCKER_GROUP/g" "/etc/tfc-agent/docker-compose.yml"

# -----------------------------------------------------------------------------
# Create service unit for tfc agent docker-compose
# -----------------------------------------------------------------------------
cat <<EOF2 > /etc/systemd/system/${service_name}.service
[Unit]
Description=${service_name}
Requires=docker.service
After=docker.service network.target

[Service]
Type=oneshot
RemainAfterExit=yes
WorkingDirectory=/etc/tfc-agent
ExecStart=/usr/bin/docker compose up -d
ExecStop=/usr/bin/docker compose down
TimeoutStartSec=0

[Install]
WantedBy=multi-user.target
EOF2

# -----------------------------------------------------------------------------
# Enable tfc-agent docker-compose service unit
# -----------------------------------------------------------------------------
systemctl daemon-reload
systemctl enable ${service_name}
systemctl start --no-block ${service_name}
