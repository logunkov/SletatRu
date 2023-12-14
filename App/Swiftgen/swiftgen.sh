#!/usr/bin/env sh

export PATH="$PATH:Swiftgen"

OUTPUT_FILES=()

COUNTER=0

while [ $COUNTER -lt ${SCRIPT_OUTPUT_FILE_COUNT} ];
do
    tmp="SCRIPT_OUTPUT_FILE_$COUNTER"
    OUTPUT_FILES+=("${!tmp}")
    COUNTER=$[$COUNTER+1]
done

for file in "${OUTPUT_FILES[@]}"
do
    if [ -f "$file" ]
    then
        chmod a=rw "$file"
    fi
done

if which swiftgen > /dev/null; then
	swiftgen config run --config Swiftgen/swiftgen.yml
else
	echo "warning: SwiftGen not installed"
	exit 1
fi

for file in "${OUTPUT_FILES[@]}"
do
    chmod a=r "$file"
done
