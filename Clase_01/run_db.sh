
#!/bin/bash

# Configuration
LOG_DIR="logs"
DB_FILE="ventas_empleado.sqlite.db"
SQL_FILE="sql_database.sql"
CSV_FILE="./csv/ventas_tienda.csv"
TIMESTAMP=$(date +%Y%m%d_%H%M%S)

# Create log directory if it doesn't exist
mkdir -p "$LOG_DIR"

# Log files
LOG_FILE="$LOG_DIR/import_${TIMESTAMP}.log"
ERROR_FILE="$LOG_DIR/import_${TIMESTAMP}_error.log"

# Function to log messages
log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $1" | tee -a "$LOG_FILE"
}

# Start logging
log "Starting import process"
log "Database: $DB_FILE"
log "SQL File: $SQL_FILE"
log "CSV File: $CSV_FILE"

# Verify files exist
verify_file() {
    if [ ! -f "$1" ]; then
        log "ERROR: File $1 not found!" | tee -a "$ERROR_FILE"
        exit 1
    fi
}

verify_file "$DB_FILE"
verify_file "$SQL_FILE"
verify_file "$CSV_FILE"

# Execute SQL import with error handling
log "Executing SQL import..."
sqlite3 "$DB_FILE" < "$SQL_FILE" 2> >(tee -a "$ERROR_FILE")

# Check exit status
if [ $? -ne 0 ]; then
    log "ERROR: SQL execution failed" | tee -a "$ERROR_FILE"
    exit 1
fi

# Verification
log "Verifying import..."
{
    echo "=== IMPORT VERIFICATION ==="
    echo "Total records:"
    sqlite3 "$DB_FILE" "SELECT COUNT(*) FROM ventas;"
    echo -e "\nSample records:"
    sqlite3 "$DB_FILE" "SELECT * FROM ventas LIMIT 3;"
} | tee -a "$LOG_FILE"

log "Import completed successfully"
exit 0
