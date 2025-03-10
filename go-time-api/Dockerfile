FROM golang:1.24.1-alpine

WORKDIR /app

COPY go.mod .

RUN go mod download
RUN go mod tidy

COPY . .

RUN go build -o time-api .

EXPOSE 8080

CMD ["./time-api"]