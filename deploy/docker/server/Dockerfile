FROM golang:1.11-alpine as builder

ENV CGO_ENABLED 0

RUN apk update \
    && apk add --no-cache git make g++ \
    && rm -rf /var/cache/apk/* \
    && adduser -D appuser \
    && mkdir -p /home/appuser/app \
    && chown -R appuser:appuser /home/appuser

COPY --chown=appuser:appuser . /home/appuser/app
WORKDIR /home/appuser/app

USER appuser

RUN go get -u github.com/go-delve/delve/cmd/dlv \
    && go get -u github.com/cortesi/modd/cmd/modd

RUN go mod download \
    && go build -o ./bin/snippetbox cmd/web/*.go

CMD ["./bin/snippetbox"]

####---- Production Image ----####

FROM alpine as production

COPY --from=builder /etc/passwd /etc/passwd
COPY --from=builder /etc/group /etc/group
COPY --from=builder --chown=appuser:appuser /home/appuser/app /home/appuser/app
WORKDIR /home/appuser/app

USER appuser

CMD ["sh", "-c", "./bin/snippetbox -dbUser=$MYSQL_USER -dbPass=$MYSQL_PASSWORD -dbHost=$MYSQL_HOST -db=$MYSQL_DATABASE"]
