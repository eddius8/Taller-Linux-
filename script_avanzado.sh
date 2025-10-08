#!/bin/bash
echo "=== SCRIPT AVANZADO ==="
echo "Acción: ${1:-ninguna}"
echo "Proceso: ${2:-ninguno}"
echo "Total argumentos: $#"
echo "Modo debug: $([[ $- == *x* ]] && echo "ACTIVO" || echo "INACTIVO")"
echo "Script finalizado"