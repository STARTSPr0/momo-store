FROM gcr.io/distroless/base-debian11
WORKDIR /
COPY ./cmd/api ./api
EXPOSE 8081
USER nonroot:nonroot
ENTRYPOINT ["go", "run", "/api"]