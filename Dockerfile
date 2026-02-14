FROM alpine:latest as builder
WORKDIR /root
RUN apk add --no-cache git make build-base && \
    git clone --branch master --single-branch https://github.com/phyznik/vlmcsd.git && \
    cd vlmcsd/ && \
    make

FROM alpine:latest
WORKDIR /root/
COPY --from=builder /root/vlmcsd/bin/vlmcsd /usr/bin/vlmcsd
COPY --from=builder /root/vlmcsd/bin/vlmcs /usr/bin/vlmcs
EXPOSE 1688/tcp
CMD [ "/usr/bin/vlmcsd", "-D", "-e", "-v"]