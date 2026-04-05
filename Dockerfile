# Build stage
# Use 'caddy:builder' for the latest builder environment
FROM caddy:builder AS builder

# Build Caddy with all required modules
RUN xcaddy build \
    --with github.com/caddy-dns/cloudflare \
    --with github.com/mholt/caddy-l4 \
    --with github.com/WeidiDeng/caddy-cloudflare-ip \
    --with github.com/fvbommel/caddy-combine-ip-ranges

# Final stage
# Use 'caddy:latest' for the actual runtime
FROM caddy:latest

# Copy the custom-built Caddy binary
COPY --from=builder /usr/bin/caddy /usr/bin/caddy
