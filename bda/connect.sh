#!/bin/bash
# Helper script to connect to the bda database
export PGPASSFILE=$PWD/.pgpass
psql -h localhost -U postgres -d bda "$@"
