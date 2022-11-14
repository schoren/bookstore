FROM golang:1.19

ARG SERVICE

# hack for shared lib
WORKDIR /app/lib
COPY ./lib/go.* /app/lib
RUN go mod download
COPY ./lib /app/lib

WORKDIR /app/${SERVICE}

COPY ./${SERVICE}/go.* /app/${SERVICE}
RUN go mod download

COPY ./${SERVICE}/* /app/${SERVICE}
RUN go build -o /app/server .

ENTRYPOINT [ "/app/server" ]
