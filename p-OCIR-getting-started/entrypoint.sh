#!/usr/bin/bash

# Define output file to capture the information
nginx_index_file="/usr/share/nginx/html/index.html"

# Capture hostname
v_hostname=$(hostname)

# Capture date
v_current_date=$(date)

# Capture private and public IP addresses
v_private_ip=$(hostname -I | tr -d '\n')
v_public_ip=$(curl -s ifconfig.me)

# Generate index.html
cat <<EOF > $nginx_index_file
<html>
<head>
  <title>Welcome to nginx on OCI</title>
  <style>body {background-color: red; text-align: center; color: white}</style>
</head>
<body>
  <h1>Welcome to nginx Web Server</h1><hr>
  <h1>Host Name: ${v_hostname} </h1><hr>
  <h2>This Homepage created at: ${v_current_date} </h2><hr>
  <h2>Server Public IP: ${v_public_ip} </h2><hr>
  <h2>Server Private IP: ${v_private_ip} </h2><hr>
</body>
</html>
EOF

# Start Nginx in the foreground so the container keeps running
nginx -g "daemon off;"
