#!/bin/bash
# Script to run the Badminton notebook with Voila

cd "$(dirname "$0")"
source venv/bin/activate
voila badminton.ipynb --port=8866 --autoreload=True

