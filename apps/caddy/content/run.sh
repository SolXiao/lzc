#!/bin/sh

FILE_PATH="/etc/caddy/Caddyfile"

if [ ! -f "$FILE_PATH" ]; then
    echo "File $FILE_PATH does not exist. Creating it."

    cat << EOF > "$FILE_PATH"
{
    auto_https off
}
EOF
fi

nohup caddy file-server --listen 0.0.0.0:2015 --root /lzcapp/pkg/content/welcome &

caddy run --config /etc/caddy/Caddyfile --adapter caddyfile
