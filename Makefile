.PHONY: all
all: build

BIN_DIR=$(PWD)/bin

dependencies:
	go mod download

build: dependencies
	go build -o $(BIN_DIR)/snippetbox cmd/web/*.go

run: build
	$(BIN_DIR)/snippetbox -addr=":4000" -dbUser="$(MYSQL_USER)" -dbPass="$(dbPass)" dbHost="$(MYSQL_HOST)" -db="$(MYSQL_DATABASE)"

help: build
	$(BIN_DIR)/snippetbox -help

install-reflex:
	go get github.com/cespare/reflex

debug: dependencies install-reflex
	reflex -c reflex.conf
