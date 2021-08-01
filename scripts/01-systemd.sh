#!/bin/bash

set -e

export DEBIAN_FRONTEND=noninteractive

apt-get update
apt-get upgrade -y
apt-get install -y sudo systemd daemonize

cat > /etc/profile.d/00-wsl2-systemd.sh <<'EOF'
#!/bin/sh
SYSTEMD_PID=`pgrep -f -- '^/lib/systemd/systemd --system-unit=basic\.target'`
if [ -z "$SYSTEMD_PID" ]; then
   sudo /usr/bin/daemonize /usr/bin/unshare --fork --pid --mount-proc /lib/systemd/systemd --system-unit=basic.target
   SYSTEMD_PID=`pgrep -f -- '^/lib/systemd/systemd --system-unit=basic\.target'`
fi
if [ -n "$SYSTEMD_PID" -a "$SYSTEMD_PID" != "1" ]; then
    exec sudo /usr/bin/nsenter -t $SYSTEMD_PID -a su - $LOGNAME
fi
EOF

cat > /etc/systemd/resolved.conf <<EOF
[Resolve]
DNS=8.8.8.8
EOF
#
