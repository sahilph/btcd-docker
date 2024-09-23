# This Dockerfile builds btcd from source by directly pulling the latest btcd image from official btcd repo ghcr.io/btcsuite/btcd
# This is a modified version of Dockerfile which is slight different from the official one, making it easier to run as a non-root user.

FROM ghcr.io/btcsuite/btcd:v0.24.2@sha256:30906cba3af79cfe857ccc370d5910470d7c74fec9b93f777d526429a7c76540

ENV HOME /

VOLUME ["/.btcd"]

COPY --chmod=555 docker-entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

CMD ["btcd"]
