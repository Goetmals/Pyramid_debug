#!/bin/bash

if [ -z "$1" ]; then
  echo "Usage: $0 fichier.imv"
  exit 1
fi

NOM="${1%.*}"

echo "Conversion de $1 en $NOM.pgm..."

# 1. On nettoie les '*' et on convertit l'HEX en DEC proprement avec AWK
# On définit la largeur pour la mise en page (ex: 128)
AWK_CMD='
BEGIN { 
    printf "P2\n128 128\n255\n"; 
    count = 0;
}
{
    gsub(/\*/, "", $0); # Supprime les astérisques
    for (i=1; i<=length($0); i+=2) {
        hex = substr($0, i, 2);
        if (hex != "") {
            printf "%d ", strtonum("0x" hex);
            count++;
            if (count % 128 == 0) printf "\n"; # Retour à la ligne tous les 128 pixels
        }
    }
}'

awk "$AWK_CMD" "$1" > "$NOM.pgm"

echo "Fichier $NOM.pgm généré avec succès."
