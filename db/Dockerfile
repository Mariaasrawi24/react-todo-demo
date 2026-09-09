FROM postgres:16-alpine

RUN apk add --no-cache curl=8.22.0-r0 jq=1.7.1-r0

COPY start.sh /usr/local/bin/vault-start.sh
RUN chmod +x /usr/local/bin/vault-start.sh

ENTRYPOINT ["/usr/local/bin/vault-start.sh"]
