FROM golang:1.21 as base

WORKDIR /APP

COPY go.mod .

RUN go mod downoload

COPY . .

RUN go build -o sai .

## final stage

FROM gcr.io/distroless/base 

COPY --from=base /APP/sai .

COPY --from=base /APP/static ./static

EXPOSE  8080

CMD [ "./sai" ]
