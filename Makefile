# Makefile for Synerex

GOCMD=go
GIT=git
GOBUILD=$(GOCMD) build
GOCLEAN=$(GOCMD) clean
GOTEST=$(GOCMD) test
GOGET=$(GOCMD) get
RM=rm

SUBTARGETS=nodeserv server provider/map provider/fleet

DOIT = $(shell if [ 30 -gt `git submodule status --recursive | wc -l` ];then echo "do"; fi)

# Main target
.PHONY: all
all: submodule build

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


.PHONY: submodule
submodule:
ifeq ("do",$(DOIT))
	$(GIT) submodule update --init --recursive
endif

