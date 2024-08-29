FROM golang:alpine AS builder
WORKDIR /build
COPY ["go.mod", "go.sum", "./"]
RUN go mod download
COPY . .
RUN go build -o momo-backend ./cmd/api

FROM alpine
WORKDIR /build
COPY --from=builder /build/momo-backend .
EXPOSE 8081
CMD ["./momo-backend"]