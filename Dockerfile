FROM golang:latest AS builder

WORKDIR /usr/src/app

COPY main.go .

RUN CGO_ENABLED=0 GOOS=linux go build -a -tags netgo -ldflags '-w' -o fullcycle main.go

FROM scratch

COPY --from=builder /usr/src/app/fullcycle /fullcycle

ENTRYPOINT ["./fullcycle"]

