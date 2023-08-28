#!/bin/bash

if [[ -n "$MODULAR_AUTH" ]]; then
    echo "Writing env-variable MODULAR_AUTH to .devcontainer/.env"
    echo "MODULAR_AUTH=$MODULAR_AUTH" > .devcontainer/.env
fi

if [[ ! -s .devcontainer/.env ]]; then
    echo "Please provide env-variable MODULAR_AUTH or create the file .devcontainer/.env with the following content:"
    echo "MODULAR_AUTH=<modular-auth-token>"
    echo ""
    exit 1
fi
