FROM golang:1.14 as builder

ENV GOPROXY="https://goproxy.cn,direct"

RUN git clone --depth 1 https://github.com/tkestack/image-transfer.git /image-transfer && \
    cd /image-transfer/cmd/image-transfer && \
    go build -ldflags '-extldflags "-static" -w -s' -o /image-transfer/image-transfer

FROM scratch 

COPY --from=builder /image-transfer/image-transfer /image-transfer

ENTRYPOINT ["/image-transfer"]