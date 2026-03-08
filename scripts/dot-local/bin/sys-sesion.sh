#!/bin/bash

# Fecha: 2024-07-24
# Autor: Franklin Cedeño Cocho
# Descripción: apagar, reiniciar, bloquear el ordenador o cerrar sesión.
# Dependencia: dmenu

set -e

main()
{
    readonly OPCIONES=$(printf '%s\n' " Apagar" " Reiniciar" " Bloquear" " Cerrar")
    readonly OPCION=$(printf "$OPCIONES" | dmenu -p " Ejecutar:" -l 4 -nb "#181825" -sb "#7aa0f5" -fn "FontAwesome-38" -sf "#000000" -c)

    case "$OPCION" in
        " Apagar") systemctl poweroff;;
        " Reiniciar") systemctl reboot;;
        " Bloquear") slock;;
        " Cerrar") pkill -SIGTERM -f "Xorg";;
        *) exit 0;;
    esac
    return 0
}

main
