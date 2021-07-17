# syntax=docker/dockerfile:1.2
# base image specifiers
ARG ELIXIR_VERSION=1.12.2
ARG ERLANG_VERSION=24.0.3
ARG DISTRO=debian
ARG DISTRO_VERSION=buster-20210326
ARG NODE_DISTRO=buster
ARG NODE_VERSION=14.17.3

###
### Core Dependancy Stage - Get the elixir base image for fetching elixir/erlang dependancies
###
FROM hexpm/elixir:${ELIXIR_VERSION}-erlang-${ERLANG_VERSION}-${DISTRO}-${DISTRO_VERSION} AS ex-deps
# syntax=docker/dockerfile:1.2
# parent image specifiers
ARG ELIXIR_VERSION=1.12.2
ARG ERLANG_VERSION=24.0.3
ARG DISTRO=debian
ARG DISTRO_VERSION=buster-20210326
ARG NODE_DISTRO=buster
ARG NODE_VERSION=14.17.3

###
### Core Dependancy Stage - Get the elixir base image for fetching elixir/erlang dependancies
###
FROM hexpm/elixir:${ELIXIR_VERSION}-erlang-${ERLANG_VERSION}-${DISTRO}-${DISTRO_VERSION} AS exlixir


ARG BUILD_TOOL_PKG=build-essential
ARG BUILD_TOOLS_VERSION="12.6"

# - install build tools
# - because we use exqlite, we need to build the [Erlang NIF interface](https://erlang.org/doc/tutorial/nif.html)
# which requires a native library compiled by the platform C compiler (gcc/clang) provided by the $BUILD_TOOLS_PKG (as # dependancies)
RUN \
    apt-get update && \
    apt-get install --no-install-recommends -y \
        "${BUILD_TOOL_PKG}=${BUILD_TOOLS_VERSION}" && \
    rm -rf /var/lib/apt/lists/*

CMD [ "/bin/bash" ]