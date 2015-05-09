#!/bin/bash
find /source \( -name __pycache__ -o -name '*.pyc' \) -delete
exec "$@"
