FROM golang:1.21 as Base

WORKDIR /APP

COPY go.mod .

RUN go mod downoload

COPY . .

RUN go build -o sai .

## final stage

FROM gcr.io/distroless/base 

COPY --from=Base /APP/sai .

COPY --from=base /APP/static ./static

EXPOSE  8080

CMD [ "./sai" ]
