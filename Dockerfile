FROM debian:bookworm-slim

ENV LITECOIN_VERSION=0.21.4
ENV LITECOIN_URL=https://github.com/litecoin-project/litecoin/releases/download/v${LITECOIN_VERSION}/litecoin-${LITECOIN_VERSION}-x86_64-linux-gnu.tar.gz

WORKDIR /app

RUN apt-get update && apt-get install -y \
    curl \
    ca-certificates \
    bash \
    tini \
    && rm -rf /var/lib/apt/lists/*

RUN curl -SL "$LITECOIN_URL" | tar -xz -C /usr/local --strip-components=1

COPY .github/docker/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
