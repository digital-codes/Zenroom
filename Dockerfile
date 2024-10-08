# Copyright 2017-2018 Dyne.org foundation
# SPDX-FileCopyrightText: 2017-2022 Dyne.org foundation
#
# SPDX-License-Identifier: AGPL-3.0-or-later

FROM alpine:latest

COPY lib /lib
COPY src /src
COPY build /build
COPY Makefile Makefile

RUN apk add --no-cache linux-headers build-base cmake readline-dev
RUN make linux
RUN cp /src/zenroom /usr/local/bin/zenroom

ENTRYPOINT ["zenroom"]

