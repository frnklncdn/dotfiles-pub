#!/bin/bash

# Fecha: 2025-03-27
# Autor: Prof. Franklin Cedeño Cocho
# Descripción: Ejecutar programas con dmenu_run

set -e

[[ -f "/usr/local/bin/dmenu_run" ]] \
  && dmenu_run -p " Ejecutar:" -l 6 -nb "#181825" -sb "#7aa0f5" -fn "FontAwesome-28" -sf "#000000" -c \
  || exit 1

