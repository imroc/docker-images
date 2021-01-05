FROM golang:1.14 as builder

RUN git clone https://github.com/tkestack/image-transfer.git /image-transfer && \
    cd /image-transfer/cmd/image-transfer && \
    go build -ldflags '-extldflags "-static" -w -s' -o /image-transfer/image-transfer

FROM scratch 

COPY --from=builder /image-transfer/image-transfer /image-transfer

ENTRYPOINT ["/image-transfer"]