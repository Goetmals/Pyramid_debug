#!/bin/sh

# on copie le fichier argument file.imv en file.pgm
#################################
#old_name=$1
#FILE=$(cp $1 ${old_name%.*}.pgm)
#################################
NOM=`echo $1 |gawk -F. '{print $1}'`
cp $NOM.imv $NOM.pgm

# suppression caractères '*' dans le nouveau fichier
#sed -i 's/*//g' $FILE
sed -i '1,$s/\*//g' $NOM.pgm

# insertion d'un espace tous les 2 caractères
sed -i '1,$s/.\{2\}/& /g' $NOM.pgm

# conversion des hexadécimaux en décimaux
sed -i 's/00/0/g' $NOM.pgm

#ajout de l'entête pour un fichier pgm
sed -i '1i P2' $NOM.pgm
sed -i -e '2i $2 $3' $NOM.pgm
sed -i -e '3i 255' $NOM.pgm

exit 0

