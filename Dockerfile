FROM python:3.11.0-slim-bullseye as build

# Version of Datasette to install, e.g. 0.55
#   docker build . -t datasette --build-arg VERSION=0.55
#   docker build . -t datasette yejiyang/datasette:no-limit-csv-publish-20221223-v2
ARG VERSION

RUN apt-get update && \
    apt-get install -y --no-install-recommends libsqlite3-mod-spatialite && \
    apt clean && \
    rm -rf /var/lib/apt && \
    rm -rf /var/lib/dpkg/info/*

RUN pip install https://github.com/ZeroPM-H2020/datasette/archive/refs/heads/no_limit_csv_publish.zip && \
    find /usr/local/lib -name '__pycache__' | xargs rm -r && \
    rm -rf /root/.cache/pip

EXPOSE 8001
CMD ["datasette"]
