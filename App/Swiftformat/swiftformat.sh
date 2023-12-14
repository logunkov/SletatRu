#!/usr/bin/env sh

export PATH="$PATH:Swiftformat"
if which swiftformat >/dev/null; then
	swiftformat . --config Swiftformat/.swiftformat
else
	echo "warning: SwiftFormat not installed"
	exit 1
fi
