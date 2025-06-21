## Update Process

```
docker compose pull
docker compose up -d
```

### Grafana

https://hub.docker.com/r/grafana/grafana/tags
https://hub.docker.com/r/prom/prometheus/tags
https://hub.docker.com/r/prom/node-exporter/tags
https://hub.docker.com/_/redis/tags

### Joplin

https://hub.docker.com/r/joplin/server/tags

### Ntfy

https://hub.docker.com/r/binwiederhier/ntfy/tags

### Uptime Kuma

https://hub.docker.com/r/louislam/uptime-kuma/tags

## Prometheus Metrics - Network Architecture

Services expose metrics endpoints via an nginx sidecar which is connected to both the prometheus network and the application network, and exposes just the metrics endpoint.
This ensures services remain isolated on their own networks, and that prometheus has access to only the metrics endpoints, without requiring firewall setup that I don't understand.

Example:

```yaml
services:
  app:
    networks:
      - internal

  prom_nginx:
    image: nginx:alpine
    networks:
      - internal
      - prom_bridge
    restart: always
    configs:
      - source: prom_nginx_config
        target: /etc/nginx/nginx.conf

configs:
  prom_nginx_config:
    content: |
      worker_processes 1;
      events {
        worker_connections 512;
      }
      http {
        server {
          listen 80;
          location /metrics {
            proxy_pass http://app:9000/metrics;
          }
          location / {
            return 403;
          }
        }
      }

networks:
  internal:
  prom_bridge:
    external: true
```
