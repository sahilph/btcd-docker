# This Dockerfile builds btcd from source by directly pulling the latest btcd from official btcd repo https://github.com/btcsuite/btcd
# This is a modified version of Dockerfile which is slight different from the official one, making it easier to build multiarch builds.
#
# 8333  Mainnet Bitcoin peer-to-peer port
# 8334  Mainet RPC port

# using the SHA256 instead of tags
# https://github.com/opencontainers/image-spec/blob/main/descriptor.md#digests
# https://cloud.google.com/architecture/using-container-images
# https://github.com/google/go-containerregistry/blob/main/cmd/crane/README.md
# ➜  ~ crane digest golang:1.17.13-alpine3.16
# sha256:c80567372be0d486766593cc722d3401038e2f150a0f6c5c719caa63afb4026a
FROM golang@sha256:c80567372be0d486766593cc722d3401038e2f150a0f6c5c719caa63afb4026a AS build-container

ADD https://github.com/btcsuite/btcd.git#v0.24.0 /app
WORKDIR /app
RUN set -ex \
  && echo "Compiling btcd" \
  && go install -v . ./cmd/...

FROM alpine:3.16@sha256:452e7292acee0ee16c332324d7de05fa2c99f9994ecc9f0779c602916a672ae4

COPY --from=build-container /go/bin /bin

VOLUME ["/btcd"]

EXPOSE 8333 8334

COPY docker-entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

CMD ["btcd"]
