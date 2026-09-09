FROM postgres:16-alpine

# hadolint ignore=DL3018
RUN apk add --no-cache curl jq

COPY start.sh /usr/local/bin/vault-start.sh
RUN chmod +x /usr/local/bin/vault-start.sh

ENTRYPOINT ["/usr/local/bin/vault-start.sh"]
