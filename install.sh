#!/bin/bash


#Ask user if they want to overwrite (if needed).
CONFIRMATION=""
read -p "Overwrite current? (Y/n): " CONFIRMATION

if [[ "$CONFIRMATION" == "" ]]; then
    CONFIRMATION="y"
fi


if [[ "$CONFIRMATION" != "y" && "$CONFIRMATION" != "Y" ]]; then
    exit 1
fi


INSTRUCTION_REGEX="(.+)\|(.+)"

#Read file.
line=""
cat config.txt | while read line; do
    if [[ "$line" == \#*  ]]; then
        continue
    fi

    echo "$line"
    if [[ "$line" =~ $INSTRUCTION_REGEX ]]; then
        echo "\"${BASH_REMATCH[1]}\" \"${BASH_REMATCH[2]}\"" #Need to handle environment variables.
    fi
done
