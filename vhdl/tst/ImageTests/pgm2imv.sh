#!/bin/sh

# Vérifie qu’un fichier est passé en argument
if [ -z "$1" ]; then
  echo "Veuillez fournir un fichier PGM au format ASCII en argument."
  exit 1
fi

# Vérifie que le fichier existe
if [ ! -f "$1" ]; then
  echo "Le fichier '$1' n'existe pas."
  exit 1
fi

# Vérifie que le fichier est bien un fichier PGM ASCII (P2)
if ! grep -q "^P2" "$1"; then
  echo "Ce fichier ne semble pas être un PGM ASCII (P2)."
  exit 1
fi

# Extraire le nom sans extension
NOM="${1%.*}"

# Lire les dimensions depuis la 2ème ligne
read LARGEUR HAUTEUR < <(sed -n '2p' "$1")
TOTAL_PIXELS=$((LARGEUR * HAUTEUR))

echo "Dimensions détectées : ${LARGEUR}x${HAUTEUR} (${TOTAL_PIXELS} pixels)"

# Copier le fichier source vers un .imv temporaire
cp "$1" "$NOM.temp"

# Supprimer les 3 premières lignes : P2, dimensions, maxval
sed -i '1,3d' "$NOM.temp"

# Conversion en hex sans espace, avec saut de ligne tous les 512 octets
awk -v total="$TOTAL_PIXELS" -v linelen="$LARGEUR" '{
  for (i = 1; i <= NF; i++) {
    count++
    printf "%02X", $i
    if (count % linelen == 0) {
      print "*"
    }
    if (count >= total) exit
  }
}' "$NOM.temp" > "$NOM.imv"

echo "Le fichier a été traité avec succès : '$NOM.imv'"

