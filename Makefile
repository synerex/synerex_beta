# Makefile for Synerex

GOCMD=go
GIT=git
MAKE=make
GOBUILD=$(GOCMD) build
GOCLEAN=$(GOCMD) clean
GOTEST=$(GOCMD) test
GOGET=$(GOCMD) get
RM=rm

SUBTARGETS=nodeserv server provider/map provider/fleet

DOIT=$(shell if [ 30 -gt `git submodule status --recursive | wc -l` ];then echo "do"; fi)

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
	cd nodeserv; ./nodeserv &
	cd server; ./synerex-server &

.PHONY: clean
clean: $(SUBTARGETS)


.PHONY: submodule
submodule:
	@if [ x$(DOIT) = "xdo" ] ; then $(GIT) submodule update --init --recursive; fi
	$(GIT) submodule -q foreach --recursive git checkout -q master

.PHONY: pushall
pushall:
	$(GIT) push --recurse-submodules=on-demand

.PHONY: supdate
supdate:
	$(GIT) submodule update --remote --merge --recursive

.PHONY: scommit
scommit:
	$(GIT) submodule -q foreach --recursive 'if [ `git status -s|wc -l` -gt 0 ]; then pwd; git commit -m "update"; fi'

.PHONY: sstatus
sstatus:
	$(GIT) submodule -q foreach --recursive git status -s
