FROM golang:1.21 as build

WORKDIR /hello
COPY go.mod .
COPY go.sum .
RUN go mod download

COPY *.go . 
RUN go build -o /hello
FROM gcr.io/distroless/static:latest

COPY --from=build /hello /
USER 65534
ENTRYPOINT ["/hello"]
