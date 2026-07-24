#!/bin/sh

# Vérification si le fichier d'entrée est fourni en argument
if [ -z "$1" ]; then
  echo "Veuillez fournir le fichier PGM en argument."
  exit 1
fi

# Extraire le nom du fichier sans l'extension (avant le premier point)
#NOM=`echo $1 |gawk -F. '{print $1}'`
NOM="${1%.*}"
# Copier le fichier PGM dans un fichier .imv
#cp $NOM.pgm $NOM.imv
cp "$1" "$NOM.imv"

#suppression des 3 premières lignes (en-tête)
sed -i '1,3d' $NOM.imv

# Traitement du fichier PGM : suppression des espaces, conversion en hexadécimal sur un octet,
# ajout d'un retour à la ligne tous les 512 octets et ajout du caractère "*" à la fin de chaque ligne.
#tr -d '[:space:]' < "$NOM.pgm" | \
#awk '{
#    for(i=1; i<=length; i++) {
#        # Ne pas ajouter d''espace entre les octets (pas de espace dans printf)
#        printf "%02X", substr($0,i,1)
#        # Ajouter un retour à la ligne tous les 512 octets et ajouter le caractère "*"
#        if (i % 512 == 0) {
#            print "*"
#        }
#    }
#} END {
    # Ajouter un "*" à la fin du fichier
#    print "*"
#}' > "$NOM.imv"

# Traitement du fichier PGM : suppression des espaces, conversion des valeurs décimales en hexadécimal
{
  # Supprimer les espaces (ou autres caractères non numériques) dans le fichier PGM
  
  
  # Lire chaque valeur décimale, les convertir en hexadécimal et les afficher
  awk 'NF > 0 {
    for (i = 1; i <= NF; i++) {
    count ++
      # Convertir chaque valeur décimale en hexadécimal sur 2 chiffres
      printf "%02X", $i
      
      # Ajouter un retour à la ligne tous les 512 octets (1024 caractères hexadécimaux)
      if (count % 965 == 0) {
        print "*"  
      }
    }
 }' "$NOM.imv" > "$NOM.imv2"
 

} # Traitement terminé

echo "Le fichier a été traité et copié sous le nom '$NOM.imv'."






