#!/usr/bin/env bash
set -e

GREEN='\033[1;32m'
RED='\033[1;31m'
NC='\033[0m'

function print_info {
    echo -e "${GREEN}`TZ=Europe/Brussels date '+%Y-%m-%d %H:%M:%S %z'` $1${NC}"
}

function print_error {
    echo -e "${RED}`TZ=Europe/Brussels date '+%Y-%m-%d %H:%M:%S %z'` $1${NC}"
}
