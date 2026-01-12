#!/bin/bash

jqExists=$(which jq)

if [[ "$jqExists" == "" ]]; then
	echo "jq is required for the script to work, please install \"jq\" to use."
	exit 1
fi

FIRST_ARG="$1"
ALL_MCVERSIONS=$(jq 'keys_unsorted | reverse | .[]' available_versions.json)

if [[ "$FIRST_ARG" == "" ]]; then
	echo -e "$ALL_MCVERSIONS"
	exit 0
fi

if echo -e "$ALL_MCVERSIONS" | grep $FIRST_ARG -q; then
	echo "Current Results:"
	echo -e "$ALL_MCVERSIONS" | grep $FIRST_ARG
else
	echo "There are no results."
fi
