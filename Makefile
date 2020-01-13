# Makefile for Synerex

GOCMD=go
GOBUILD=$(GOCMD) build
GOCLEAN=$(GOCMD) clean
GOTEST=$(GOCMD) test
GOGET=$(GOCMD) get
RM=rm

SUBTARGETS=nodeserv server provider/map provider/fleet

# Main target

.PHONY: build 
build: $(SUBTARGETS)

.PHONY: $(SUBTARGETS)

$(SUBTARGETS):
	$(MAKE) -C $@ $(MAKECMDGOALS)


.PHONY: runserver
runserver:
	nodeserv/nodeserv &
	server/synerex-server &

.PHONY: clean
clean: $(SUBTARGETS)
