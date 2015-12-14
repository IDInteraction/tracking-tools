#------------------------------------------------------------------------------
# Copyright (c) 2015 The University of Manchester, UK.
#
# Licenced under LGPL version 2.1. See LICENCE for details.
#
# The IDInteraction Object Tracking Tools were developed in the IDInteraction
# project, funded by the Engineering and Physical Sciences Research Council,
# UK through grant agreement number EP/M017133/1.
#
# Author: Robert Haines
#------------------------------------------------------------------------------

system-dir=/usr/local/bin
user-dir=$(HOME)/bin

.PHONY: all install

# If run as root, install centrally for all users.
# If not, install for current user only.
root := $(shell id -u)
ifeq ($(root),0)
	install-dir = $(system-dir)
else
	install-dir = $(user-dir)
endif

all: install

# Create the installation directory if needed.
# Should not be needed for root installs.
$(install-dir):
	mkdir $(install-dir)

install: | $(install-dir)
	for file in $(shell git ls-files --exclude-standard -- bin/idi-[a-z]*); do \
		full=$$(readlink -f $$file); \
		copy=$$(basename $$file); \
		cp -u $$full $(install-dir)/$$copy; \
	done
