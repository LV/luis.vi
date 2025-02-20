.PHONY: all build

all: build

build:
	emacs -Q --script build-site.el
