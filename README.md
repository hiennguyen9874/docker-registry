# Docker Registry

## Usage

### Localhost

- `docker run --entrypoint htpasswd httpd:2 -Bbn myuser mypassword > registry-config/htpasswd`
- `docker-compose up -d`
- `docker login localhost:10102`:
  - user: `myuser`
  - password: `mypassword`
- Open [localhost:8080](http://localhost:8080)
- `bash ./populate.sh`

### Nginx

```nginx
server {
    listen 443 ssl http2;
    server_name hub.example.com;

    ssl_certificate /etc/letsencrypt/live/hub.example.com/fullchain.pem; # managed by Certbot
    ssl_certificate_key /etc/letsencrypt/live/hub.example.com/privkey.pem; # managed by Certbot

    # Recommendations from https://raymii.org/s/tutorials/Strong_SSL_Security_On_nginx.html
    ssl_protocols TLSv1.1 TLSv1.2;
    ssl_ciphers 'EECDH+AESGCM:EDH+AESGCM:AES256+EECDH:AES256+EDH';
    ssl_prefer_server_ciphers on;
    ssl_session_cache shared:SSL:10m;

    charset utf-8;

    proxy_send_timeout 120;
    proxy_read_timeout 300;
    proxy_buffering    off;
    keepalive_timeout  5 5;
    tcp_nodelay        on;

    # disable any limits to avoid HTTP 413 for large image uploads
    client_max_body_size 0;

    # required to avoid HTTP 411: see Issue #1486 (https://github.com/moby/moby/issues/1486)
    chunked_transfer_encoding on;

    location / {
        proxy_pass http://0.0.0.0:10102;

        proxy_set_header  Host              $http_host;   # required for docker client's sake
        proxy_set_header  X-Real-IP         $remote_addr; # pass on real client's IP
        proxy_set_header  X-Forwarded-For   $proxy_add_x_forwarded_for;
        proxy_set_header  X-Forwarded-Proto $scheme;
        proxy_read_timeout                  900;
    }
}
```

# Acknowledgements

- [github.com/Joxit/docker-registry-ui](https://github.com/Joxit/docker-registry-ui)
