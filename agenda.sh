#!/bin/bash

AGENDA="agenda.txt"

mostrar_menu() {
    echo "----------------------------------"
    echo "        AGENDA TELEFÓNICA         "
    echo "----------------------------------"
    echo "1. Agregar contacto"
    echo "2. Consultar contacto"
    echo "3. Borrar contacto"
    echo "4. Listar contactos"
    echo "5. Ordenar por nombre"
    echo "6. Ordenar por teléfono"
    echo "7. Generar reporte"
    echo "0. Salir"
    echo "----------------------------------"
    echo -n "Selecciona una opción: "
}

agregar_contacto() {
    echo -n "Ingrese el nombre del contacto: "
    read nombre
    if [ ! -f "$AGENDA" ]; then
        touch "$AGENDA"
        echo "Se ha creado el archivo $AGENDA"
    fi
    if grep -q "^$nombre:" "$AGENDA"; then
        echo "El contacto ya existe."
    else
        echo -n "Ingrese el número de teléfono: "
        read telefono
        echo "$nombre:$telefono" >> "$AGENDA"
        echo "Contacto agregado con éxito."
    fi
}

consultar_contacto() {
    echo -n "Ingrese el nombre del contacto a consultar: "
    read nombre
    telefono=$(grep "^$nombre:" "$AGENDA" | cut -d ':' -f2)
    if [ -z "$telefono" ]; then
        echo "Contacto no encontrado."
    else
        echo "El teléfono de $nombre es: $telefono"
    fi
}

borrar_contacto() {
    echo -n "Ingrese el nombre del contacto a borrar: "
    read nombre
    if grep -q "^$nombre:" "$AGENDA"; then
        sed -i "/^$nombre:/d" "$AGENDA"
        echo "Contacto '$nombre' borrado exitosamente."
    else
        echo "Contacto no encontrado."
    fi
}

listar_contactos() {
    if [ ! -f "$AGENDA" ] || [ ! -s "$AGENDA" ]; then
        echo "La agenda está vacía."
    else
        echo "Lista de contactos:"
        cut -d ':' -f1 "$AGENDA" | sort
    fi
}

ordenar_por_nombre() {
    if [ ! -f "$AGENDA" ] || [ ! -s "$AGENDA" ]; then
        echo "La agenda está vacía."
    else
        sort -t ':' -k1,1 "$AGENDA" > agenda_temp.txt
        mv agenda_temp.txt "$AGENDA"
        echo "Contactos ordenados por nombre."
        listar_contactos
    fi
}

ordenar_por_telefono() {
    if [ ! -f "$AGENDA" ] || [ ! -s "$AGENDA" ]; then
        echo "La agenda está vacía."
    else
        sort -t ':' -k2,2 "$AGENDA" > agenda_temp.txt
        mv agenda_temp.txt "$AGENDA"
        echo "Contactos ordenados por teléfono."
        listar_contactos
    fi
}

generar_reporte() {
    if [ ! -f "$AGENDA" ] || [ ! -s "$AGENDA" ]; then
        echo "La agenda está vacía. No se puede generar reporte."
    else
        sort -t ':' -k1,1 "$AGENDA" > reporte.txt
        echo "Reporte generado en 'reporte.txt'"
    fi
}

while true; do
    mostrar_menu
    read opcion
    case $opcion in
        1) agregar_contacto ;;
        2) consultar_contacto ;;
        3) borrar_contacto ;;
        4) listar_contactos ;;
        5) ordenar_por_nombre ;;
        6) ordenar_por_telefono ;;
        7) generar_reporte ;;
        0) echo "Saliendo..."; exit 0 ;;
        *) echo "Opción no válida, intenta de nuevo." ;;
    esac
done