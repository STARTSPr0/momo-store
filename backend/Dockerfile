#Сборка
FROM golang:1.17 AS builder
WORKDIR /app
COPY go.mod go.sum ./
RUN go mod download
COPY *.go ./
RUN go build -o /back-momo
#релиз
FROM gcr.io/distroless/base-debian11 AS release
WORKDIR /
COPY --from=builder /back-momo /back-momo
EXPOSE 8081
USER nonroot:nonroot
ENTRYPOINT ["/back-momo/cmd/api"]