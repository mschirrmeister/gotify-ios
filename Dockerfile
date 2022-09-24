FROM debian:stable-slim
RUN apt-get update && apt-get install -y \
  pip \
  jq \
  curl \
  screen \
  procps \
  && rm -rf /var/lib/apt/lists/*
RUN pip install ntfy
RUN curl -L https://github.com/vi/websocat/releases/download/v1.10.0/websocat.aarch64-unknown-linux-musl -o /usr/local/bin/websocat && \
  chmod 755 /usr/local/bin/websocat
RUN groupadd -g 999 appuser && \
    useradd -r -m -u 999 -g appuser appuser

USER appuser

COPY gotify-sync.sh /usr/local/bin/
COPY docker-entrypoint.sh /usr/local/bin/

ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["sleep", "infinity"]
