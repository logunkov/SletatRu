#!/usr/bin/env sh

export PATH="$PATH:Swiftlint"
if which swiftlint > /dev/null; then
	swiftlint --fix
	swiftlint --config Swiftlint/.swiftlint.yml
else
	echo "warning: SwiftLint not installed"
	exit 1
fi
