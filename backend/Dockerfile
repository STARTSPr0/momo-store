#Сборка
FROM golang:1.17 AS builder
WORKDIR /app
COPY go.mod go.sum ./cmd/api ./
RUN go mod download && go build -o /back-momo
#релиз
FROM gcr.io/distroless/base-debian11 AS release
WORKDIR /
COPY --from=builder /back-momo /back-momo
EXPOSE 8081
USER nonroot:nonroot
ENTRYPOINT ["/back-momo"]