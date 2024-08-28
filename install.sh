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

echo ""


#INSTRUCTION_REGEX="(.+)\|(.+)"
INSTRUCTION_REGEX="(.+)\|\"*([^\"]+)\"*"
HOME_REGEX="\~(.*)"
#REDIRECT_REGEX="(.*)\$(.*)"    #Not currently working, might add in the future.

#Read file.
line=""
cat config.txt | while read line; do
    if [[ "$line" == \#* ]]; then
        continue
    fi


    if [[ -z "$line" ]]; then
        continue
    fi


    #echo "$line"
    if [[ "$line" =~ $INSTRUCTION_REGEX ]]; then
        #if [[ ${BASH_REMATCH[2]} == *\$* ]]; then
        #    echo "${!${BASH_REMATCH[2]}}"
        #    #echo "${BASH_REMATCH[2]}"
        #fi

        #echo "\"${BASH_REMATCH[1]}\" \"${BASH_REMATCH[2]}\"" #Need to handle environment variables.
        COPYABLE="${BASH_REMATCH[1]}"

        #DESTINATION=$(dirname "${BASH_REMATCH[2]}")
        DESTINATION="${BASH_REMATCH[2]}"

        if [[ "$DESTINATION" =~ $HOME_REGEX ]]; then
            DESTINATION="/home/$(whoami)${BASH_REMATCH[1]}"
        fi


        if [[ ! -e "$COPYABLE" ]]; then
            echo "The file/folder \"$COPYABLE\" doesn't exist." >&2
            echo ""

            continue
        fi


        mkdir -p "$DESTINATION"

        #Just checking if the path is actually there, as it's not guaranteed.
        if [[ ! -d $DESTINATION ]]; then
            echo "The destination folder \"$DESTINATION\" was not successfully created." >&2

            continue
        fi


        cp -r "$COPYABLE" "$DESTINATION"

        echo "Successfully copied \"$COPYABLE\" into \"$DESTINATION\"!"
    else
        echo "Not a recognized instruction!" >&2
    fi


    echo ""
done
