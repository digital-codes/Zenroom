## Initialize build defaults
include build/init.mk

COMPILER ?= gcc

ifdef LINUX
	system := Linux
	cflags += -fPIC -D'ARCH="LINUX"' -DARCH_LINUX
	ldadd += -lm
endif

ifdef OSX
	COMPILER := clang
	cflags += -fPIC -D'ARCH="OSX"' -DARCH_OSX
endif

# default is DEBUG
ifdef RELEASE
	cflags += -O3 ${cflags_protection}
else
	cflags += ${cflags_debug}
endif

ifdef LIBRARY
	cflags += -DLIBRARY
endif

# activate CCACHE etc.
include build/plugins.mk

all: deps zenroom zencode-exec

deps: ${BUILD_DEPS}

cli_sources := src/cli-zenroom.o src/repl.o
zenroom: ${ZEN_SOURCES} ${cli_sources}
	$(info === Building the zenroom CLI)
	${zenroom_cc} ${cflags} ${ZEN_SOURCES} ${cli_sources} \
		-o $@ ${ldflags} ${ldadd} -lreadline

zencode-exec: ${ZEN_SOURCES} src/zencode-exec.o
	$(info === Building the zencode-exec utility)
	${zenroom_cc} ${cflags} ${ZEN_SOURCES} src/zencode-exec.o \
		-o $@ ${ldflags} ${ldadd}

libzenroom.so: deps ${ZEN_SOURCES}
	$(info === Building the zenroom shared library)
	${zenroom_cc} ${cflags} -shared ${ZEN_SOURCES} \
		-o $@ ${ldflags} ${ldadd}

# OSX specific target
libzenroom.dylib: deps ${ZEN_SOURCES}
	$(info === Building the zenroom shared dynamic library)
	${zenroom_cc} ${cflags} -shared ${ZEN_SOURCES} -dynamiclib \
		-o $@ ${ldflags} ${ldadd}

include build/deps.mk
