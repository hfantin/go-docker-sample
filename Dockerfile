FROM golang:1.23.0-bullseye as base

RUN adduser \
  --disabled-password \
  --gecos "" \
  --home "/nonexistent" \
  --shell "/sbin/nologin" \
  --no-create-home \
  --uid 65532 \
  hfantin

WORKDIR /app

COPY go.mod ./
COPY *.go ./

RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o go-docker-sample

FROM scratch

WORKDIR /app

COPY --from=base /app/go-docker-sample .

CMD ["/app/go-docker-sample"]