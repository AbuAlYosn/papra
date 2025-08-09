FROM ghcr.io/paperless-ngx/paperless-ngx:2.17.1

USER root
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
       tesseract-ocr-ara \
       fonts-noto \
       fonts-dejavu \
    && rm -rf /var/lib/apt/lists/*
USER paperless