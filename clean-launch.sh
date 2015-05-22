#!/bin/bash
echo ">>> removing all .pyc files"
find /source \( -name __pycache__ -o -name '*.pyc' \) -delete
echo ">>> executing command"
exec "$@"
