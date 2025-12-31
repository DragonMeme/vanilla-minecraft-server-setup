#!/bin/bash

usage()
{
cat << EOF
Usage: $0 -mcv MC_VERSION

This script launches the minecraft server in a docker container.

OPTIONS:
   -mcv MC_VERSION  The version of minecraft version server to use.
   -h               Show this message
EOF
}

MCVERSION=
JAVA_VERSION=8

while (( $# )); do
	case "$1" in
		-mcv | --minecraft-version ) MCVERSION=$2; shift 2;;
		-h | --help )                usage; exit 0;;
		* )                          usage; exit 1;;
	esac
done

PATTERN="^[0-9]+\.[0-9]+\.[0-9]+$"

if [[ ! $MCVERSION =~ $PATTERN ]]; then
	echo "Argument '$MCVERSION' is NOT a valid version number \(x.xx.x format\)."
	exit 1
fi

MINOR_VERSION_NUMBER=$(( $(echo $MCVERSION | grep -oP "[0-9]+" | sed -n 2p) ))
PATCH_VERSION_NUMBER=$(( $(echo $MCVERSION | grep -oP "[0-9]+" | sed -n 3p) ))

if (( MINOR_VERSION_NUMBER >= 18 )); then
	JAVA_VERSION=17
fi

# For versions 20.5 and newer in the v1.20 series, use java 21.
if (( MINOR_VERSION_NUMBER == 20 )); then
	if (( PATCH_VERSION_NUMBER >= 5 )); then
		JAVA_VERSION=21
	fi
fi

if (( MINOR_VERSION_NUMBER >= 21 )); then
	JAVA_VERSION=21
fi

echo "JAVA_VERSION=$JAVA_VERSION" > .env
echo "MC_VERSION=$MCVERSION" >> .env
echo "USER=$USER" >> .env
