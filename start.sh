#!/bin/bash
set -e

vector -c vector.yaml &

python3 scrape_logs.py
