#!/bin/bash
echo "=== SISTEMA DE BACKUP ==="
mkdir -p backups
archivos=$(find . -name "*.sh" -type f | head -5)
tar -czf backups/backup_$(date +%Y%m%d).tar.gz $archivos 2>/dev/null
echo "Backup creado: backups/backup_$(date +%Y%m%d).tar.gz"
echo "Archivos incluidos: $(echo "$archivos" | wc -l)"
echo "Backup completado"