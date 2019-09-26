# README
Service Integration Platform for Smart Cities and Society 5.0

Synerex_beta is a submodule repository for Synerex service platform.

## Installation
Currently, go build is required for each submodules.

    git clone https://github.com/synerex/synerex_beta.git
    cd synerex_beta
    git submodule update --init –-recursive

    cd nodeserv
    go build

    cd ../server
    go build

### for Providers

    cd ../provider/fleet
    go build

    cd ../provider/map
    go build

    cd ../provider/harmovis
    go build

### for Gateways

    cd ../gateway/simple
    go build
