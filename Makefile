.PHONY: all
all: build

BIN_DIR=$(PWD)/bin

dependencies:
	go mod download

build: dependencies
	go build -o $(BIN_DIR)/snippetbox cmd/web/*.go

run: build
	$(BIN_DIR)/snippetbox -addr=":4000" -dsn="$(MYSQL_USER):$(MYSQL_PASSWORD)@tcp($(MYSQL_HOST))/$(MYSQL_DATABASE)?parseTime=true"

help: build
	$(BIN_DIR)/snippetbox -help

install-reflex:
	go get github.com/cespare/reflex

debug: dependencies install-reflex
	reflex -c reflex.conf
