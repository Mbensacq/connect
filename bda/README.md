# TP SQL 1 - PostgreSQL Environment

## Setup Complete ✓

Your PostgreSQL environment is ready to use with:
- **Database**: `bda` running in Docker container `bda-db`
- **Port**: `localhost:5432`
- **User**: `postgres`
- **Password**: `postgres` (stored in `.pgpass`)

## Files

- `docker-compose.yml` - Postgres 15 container definition
- `db/init/init.sql` - Initial schema and sample data (auto-loaded on first start)
- `queries.sql` - Your TP SQL queries
- `.pgpass` - Password file for passwordless psql access
- `connect.sh` - Helper script to connect to the database

## Quick Start

### Start the database
```bash
docker rm -f bda-db || true
docker run -d --name bda-db -p 5432:5432 \
  -v "$PWD/db/init":/docker-entrypoint-initdb.d:ro \
  -e POSTGRES_DB=bda -e POSTGRES_USER=postgres -e POSTGRES_PASSWORD=postgres \
  postgres:15
```

### Connect to the database

Using the helper script:
```bash
./connect.sh
```

Or directly with psql:
```bash
export PGPASSFILE=$PWD/.pgpass
psql -h localhost -U postgres -d bda
```

### Run your queries
```bash
./connect.sh -f queries.sql
```

## Useful Commands

List all tables:
```bash
./connect.sh -c "\dt"
```

View table structure:
```bash
./connect.sh -c "\d COMMUNE"
```

Quick query:
```bash
./connect.sh -c "SELECT * FROM COMMUNE;"
```

## Database Schema

- **COMMUNE** (codeCommune, nomCommune, codePostal, nbHabitants)
- **CAMION** (numImmat, nomProprietaire, miseEnService, is_active)
- **TYPEDECHET** (codeType, libelleType)
- **DEPOT** (numDepot, dateDepot, heureDepot, poidsArrivee, poidsDepart, codeType, numImmat, codeCommune)

## Notes

- The init.sql creates tables with proper constraints (foreign keys, check constraints for positive values)
- Sample data is pre-loaded on container startup
- The `.pgpass` file stores your password securely (mode 600)
- Container persists data until removed with `docker rm -f bda-db`
