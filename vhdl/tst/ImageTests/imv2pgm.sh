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
sed -i -e "s/00/0/g" $NOM.pgm
sed -i -e "s/01/1/g" $NOM.pgm
sed -i -e "s/02/2/g" $NOM.pgm
sed -i -e "s/03/3/g" $NOM.pgm
sed -i -e "s/04/4/g" $NOM.pgm
sed -i -e "s/05/5/g" $NOM.pgm
sed -i -e "s/06/6/g" $NOM.pgm
sed -i -e "s/07/7/g" $NOM.pgm
sed -i -e "s/08/8/g" $NOM.pgm
sed -i -e "s/09/9/g" $NOM.pgm
sed -i -e "s/0A/10/g" $NOM.pgm
sed -i -e "s/0B/11/g" $NOM.pgm
sed -i -e "s/0C/12/g" $NOM.pgm
sed -i -e "s/0D/13/g" $NOM.pgm
sed -i -e "s/0E/14/g" $NOM.pgm
sed -i -e "s/0F/15/g" $NOM.pgm

sed -i -e "s/10/16/g" $NOM.pgm
sed -i -e "s/11/17/g" $NOM.pgm
sed -i -e "s/12/18/g" $NOM.pgm
sed -i -e "s/13/19/g" $NOM.pgm
sed -i -e "s/14/20/g" $NOM.pgm
sed -i -e "s/15/21/g" $NOM.pgm
sed -i -e "s/16/22/g" $NOM.pgm
sed -i -e "s/17/23/g" $NOM.pgm
sed -i -e "s/18/24/g" $NOM.pgm
sed -i -e "s/19/25/g" $NOM.pgm
sed -i -e "s/1A/26/g" $NOM.pgm
sed -i -e "s/1B/27/g" $NOM.pgm
sed -i -e "s/1C/28/g" $NOM.pgm
sed -i -e "s/1D/29/g" $NOM.pgm
sed -i -e "s/1E/30/g" $NOM.pgm
sed -i -e "s/1F/31/g" $NOM.pgm

sed -i -e "s/20/32/g" $NOM.pgm
sed -i -e "s/21/33/g" $NOM.pgm
sed -i -e "s/22/34/g" $NOM.pgm
sed -i -e "s/23/35/g" $NOM.pgm
sed -i -e "s/24/36/g" $NOM.pgm
sed -i -e "s/25/37/g" $NOM.pgm
sed -i -e "s/26/38/g" $NOM.pgm
sed -i -e "s/27/39/g" $NOM.pgm
sed -i -e "s/28/40/g" $NOM.pgm
sed -i -e "s/29/41/g" $NOM.pgm
sed -i -e "s/2A/42/g" $NOM.pgm
sed -i -e "s/2B/43/g" $NOM.pgm
sed -i -e "s/2C/44/g" $NOM.pgm
sed -i -e "s/2D/45/g" $NOM.pgm
sed -i -e "s/2E/46/g" $NOM.pgm
sed -i -e "s/2F/47/g" $NOM.pgm

sed -i -e "s/30/48/g" $NOM.pgm
sed -i -e "s/31/49/g" $NOM.pgm
sed -i -e "s/32/50/g" $NOM.pgm
sed -i -e "s/33/51/g" $NOM.pgm
sed -i -e "s/34/52/g" $NOM.pgm
sed -i -e "s/35/53/g" $NOM.pgm
sed -i -e "s/36/54/g" $NOM.pgm
sed -i -e "s/37/55/g" $NOM.pgm
sed -i -e "s/38/56/g" $NOM.pgm
sed -i -e "s/39/57/g" $NOM.pgm
sed -i -e "s/3A/58/g" $NOM.pgm
sed -i -e "s/3B/59/g" $NOM.pgm
sed -i -e "s/3C/60/g" $NOM.pgm
sed -i -e "s/3D/61/g" $NOM.pgm
sed -i -e "s/3E/62/g" $NOM.pgm
sed -i -e "s/3F/63/g" $NOM.pgm

sed -i -e "s/40/64/g" $NOM.pgm
sed -i -e "s/41/65/g" $NOM.pgm
sed -i -e "s/42/66/g" $NOM.pgm
sed -i -e "s/43/67/g" $NOM.pgm
sed -i -e "s/44/68/g" $NOM.pgm
sed -i -e "s/45/69/g" $NOM.pgm
sed -i -e "s/46/70/g" $NOM.pgm
sed -i -e "s/47/71/g" $NOM.pgm
sed -i -e "s/48/72/g" $NOM.pgm
sed -i -e "s/49/73/g" $NOM.pgm
sed -i -e "s/4A/74/g" $NOM.pgm
sed -i -e "s/4B/75/g" $NOM.pgm
sed -i -e "s/4C/76/g" $NOM.pgm
sed -i -e "s/4D/77/g" $NOM.pgm
sed -i -e "s/4E/78/g" $NOM.pgm
sed -i -e "s/4F/79/g" $NOM.pgm

sed -i -e "s/50/80/g" $NOM.pgm
sed -i -e "s/51/81/g" $NOM.pgm
sed -i -e "s/52/82/g" $NOM.pgm
sed -i -e "s/53/83/g" $NOM.pgm
sed -i -e "s/54/84/g" $NOM.pgm
sed -i -e "s/55/85/g" $NOM.pgm
sed -i -e "s/56/86/g" $NOM.pgm
sed -i -e "s/57/87/g" $NOM.pgm
sed -i -e "s/58/88/g" $NOM.pgm
sed -i -e "s/59/89/g" $NOM.pgm
sed -i -e "s/5A/90/g" $NOM.pgm
sed -i -e "s/5B/91/g" $NOM.pgm
sed -i -e "s/5C/92/g" $NOM.pgm
sed -i -e "s/5D/93/g" $NOM.pgm
sed -i -e "s/5E/94/g" $NOM.pgm
sed -i -e "s/5F/95/g" $NOM.pgm

sed -i -e "s/60/96/g" $NOM.pgm
sed -i -e "s/61/97/g" $NOM.pgm
sed -i -e "s/62/98/g" $NOM.pgm
sed -i -e "s/63/99/g" $NOM.pgm
sed -i -e "s/64/100/g" $NOM.pgm
sed -i -e "s/65/101/g" $NOM.pgm
sed -i -e "s/66/102/g" $NOM.pgm
sed -i -e "s/67/103/g" $NOM.pgm
sed -i -e "s/68/104/g" $NOM.pgm
sed -i -e "s/69/105/g" $NOM.pgm
sed -i -e "s/6A/106/g" $NOM.pgm
sed -i -e "s/6B/107/g" $NOM.pgm
sed -i -e "s/6C/108/g" $NOM.pgm
sed -i -e "s/6D/109/g" $NOM.pgm
sed -i -e "s/6E/110/g" $NOM.pgm
sed -i -e "s/6F/111/g" $NOM.pgm

sed -i -e "s/70/112/g" $NOM.pgm
sed -i -e "s/71/113/g" $NOM.pgm
sed -i -e "s/72/114/g" $NOM.pgm
sed -i -e "s/73/115/g" $NOM.pgm
sed -i -e "s/74/116/g" $NOM.pgm
sed -i -e "s/75/117/g" $NOM.pgm
sed -i -e "s/76/118/g" $NOM.pgm
sed -i -e "s/77/119/g" $NOM.pgm
sed -i -e "s/78/120/g" $NOM.pgm
sed -i -e "s/79/121/g" $NOM.pgm
sed -i -e "s/7A/122/g" $NOM.pgm
sed -i -e "s/7B/123/g" $NOM.pgm
sed -i -e "s/7C/124/g" $NOM.pgm
sed -i -e "s/7D/125/g" $NOM.pgm
sed -i -e "s/7E/126/g" $NOM.pgm
sed -i -e "s/7F/127/g" $NOM.pgm

sed -i -e "s/80/128/g" $NOM.pgm
sed -i -e "s/81/129/g" $NOM.pgm
sed -i -e "s/82/130/g" $NOM.pgm
sed -i -e "s/83/131/g" $NOM.pgm
sed -i -e "s/84/132/g" $NOM.pgm
sed -i -e "s/85/133/g" $NOM.pgm
sed -i -e "s/86/134/g" $NOM.pgm
sed -i -e "s/87/135/g" $NOM.pgm
sed -i -e "s/88/136/g" $NOM.pgm
sed -i -e "s/89/137/g" $NOM.pgm
sed -i -e "s/8A/138/g" $NOM.pgm
sed -i -e "s/8B/139/g" $NOM.pgm
sed -i -e "s/8C/140/g" $NOM.pgm
sed -i -e "s/8D/141/g" $NOM.pgm
sed -i -e "s/8E/142/g" $NOM.pgm
sed -i -e "s/8F/143/g" $NOM.pgm

sed -i -e "s/90/144/g" $NOM.pgm
sed -i -e "s/91/145/g" $NOM.pgm
sed -i -e "s/92/146/g" $NOM.pgm
sed -i -e "s/93/147/g" $NOM.pgm
sed -i -e "s/94/148/g" $NOM.pgm
sed -i -e "s/95/149/g" $NOM.pgm
sed -i -e "s/96/150/g" $NOM.pgm
sed -i -e "s/97/151/g" $NOM.pgm
sed -i -e "s/98/152/g" $NOM.pgm
sed -i -e "s/99/153/g" $NOM.pgm
sed -i -e "s/9A/154/g" $NOM.pgm
sed -i -e "s/9B/155/g" $NOM.pgm
sed -i -e "s/9C/156/g" $NOM.pgm
sed -i -e "s/9D/157/g" $NOM.pgm
sed -i -e "s/9E/158/g" $NOM.pgm
sed -i -e "s/9F/159/g" $NOM.pgm

sed -i -e "s/A0/160/g" $NOM.pgm
sed -i -e "s/A1/161/g" $NOM.pgm
sed -i -e "s/A2/162/g" $NOM.pgm
sed -i -e "s/A3/163/g" $NOM.pgm
sed -i -e "s/A4/164/g" $NOM.pgm
sed -i -e "s/A5/165/g" $NOM.pgm
sed -i -e "s/A6/166/g" $NOM.pgm
sed -i -e "s/A7/167/g" $NOM.pgm
sed -i -e "s/A8/168/g" $NOM.pgm
sed -i -e "s/A9/169/g" $NOM.pgm
sed -i -e "s/AA/170/g" $NOM.pgm
sed -i -e "s/AB/171/g" $NOM.pgm
sed -i -e "s/AC/172/g" $NOM.pgm
sed -i -e "s/AD/173/g" $NOM.pgm
sed -i -e "s/AE/174/g" $NOM.pgm
sed -i -e "s/AF/175/g" $NOM.pgm

sed -i -e "s/B0/176/g" $NOM.pgm
sed -i -e "s/B1/177/g" $NOM.pgm
sed -i -e "s/B2/178/g" $NOM.pgm
sed -i -e "s/B3/179/g" $NOM.pgm
sed -i -e "s/B4/180/g" $NOM.pgm
sed -i -e "s/B5/181/g" $NOM.pgm
sed -i -e "s/B6/182/g" $NOM.pgm
sed -i -e "s/B7/183/g" $NOM.pgm
sed -i -e "s/B8/184/g" $NOM.pgm
sed -i -e "s/B9/185/g" $NOM.pgm
sed -i -e "s/BA/186/g" $NOM.pgm
sed -i -e "s/BB/187/g" $NOM.pgm
sed -i -e "s/BC/188/g" $NOM.pgm
sed -i -e "s/BD/189/g" $NOM.pgm
sed -i -e "s/BE/190/g" $NOM.pgm
sed -i -e "s/BF/191/g" $NOM.pgm

sed -i -e "s/C0/192/g" $NOM.pgm
sed -i -e "s/C1/193/g" $NOM.pgm
sed -i -e "s/C2/194/g" $NOM.pgm
sed -i -e "s/C3/195/g" $NOM.pgm
sed -i -e "s/C4/196/g" $NOM.pgm
sed -i -e "s/C5/197/g" $NOM.pgm
sed -i -e "s/C6/198/g" $NOM.pgm
sed -i -e "s/C7/199/g" $NOM.pgm
sed -i -e "s/C8/200/g" $NOM.pgm
sed -i -e "s/C9/201/g" $NOM.pgm
sed -i -e "s/CA/202/g" $NOM.pgm
sed -i -e "s/CB/203/g" $NOM.pgm
sed -i -e "s/CC/204/g" $NOM.pgm
sed -i -e "s/CD/205/g" $NOM.pgm
sed -i -e "s/CE/206/g" $NOM.pgm
sed -i -e "s/CF/207/g" $NOM.pgm

sed -i -e "s/D0/208/g" $NOM.pgm
sed -i -e "s/D1/209/g" $NOM.pgm
sed -i -e "s/D2/210/g" $NOM.pgm
sed -i -e "s/D3/211/g" $NOM.pgm
sed -i -e "s/D4/212/g" $NOM.pgm
sed -i -e "s/D5/213/g" $NOM.pgm
sed -i -e "s/D6/214/g" $NOM.pgm
sed -i -e "s/D7/215/g" $NOM.pgm
sed -i -e "s/D8/216/g" $NOM.pgm
sed -i -e "s/D9/217/g" $NOM.pgm
sed -i -e "s/DA/218/g" $NOM.pgm
sed -i -e "s/DB/219/g" $NOM.pgm
sed -i -e "s/DC/220/g" $NOM.pgm
sed -i -e "s/DD/221/g" $NOM.pgm
sed -i -e "s/DE/222/g" $NOM.pgm
sed -i -e "s/DF/223/g" $NOM.pgm

sed -i -e "s/E0/224/g" $NOM.pgm
sed -i -e "s/E1/225/g" $NOM.pgm
sed -i -e "s/E2/226/g" $NOM.pgm
sed -i -e "s/E3/227/g" $NOM.pgm
sed -i -e "s/E4/228/g" $NOM.pgm
sed -i -e "s/E5/229/g" $NOM.pgm
sed -i -e "s/E6/230/g" $NOM.pgm
sed -i -e "s/E7/231/g" $NOM.pgm
sed -i -e "s/E8/232/g" $NOM.pgm
sed -i -e "s/E9/233/g" $NOM.pgm
sed -i -e "s/EA/234/g" $NOM.pgm
sed -i -e "s/EB/235/g" $NOM.pgm
sed -i -e "s/EC/236/g" $NOM.pgm
sed -i -e "s/ED/237/g" $NOM.pgm
sed -i -e "s/EE/238/g" $NOM.pgm
sed -i -e "s/EF/239/g" $NOM.pgm

sed -i -e "s/F0/224/g" $NOM.pgm
sed -i -e "s/F1/225/g" $NOM.pgm
sed -i -e "s/F2/226/g" $NOM.pgm
sed -i -e "s/F3/227/g" $NOM.pgm
sed -i -e "s/F4/228/g" $NOM.pgm
sed -i -e "s/F5/229/g" $NOM.pgm
sed -i -e "s/F6/230/g" $NOM.pgm
sed -i -e "s/F7/231/g" $NOM.pgm
sed -i -e "s/F8/232/g" $NOM.pgm
sed -i -e "s/F9/233/g" $NOM.pgm
sed -i -e "s/FA/234/g" $NOM.pgm
sed -i -e "s/FB/235/g" $NOM.pgm
sed -i -e "s/FC/236/g" $NOM.pgm
sed -i -e "s/FD/237/g" $NOM.pgm
sed -i -e "s/FE/238/g" $NOM.pgm
sed -i -e "s/FF/239/g" $NOM.pgm

#ajout de l'entête pour un fichier pgm
sed -i '1i P2' $NOM.pgm
sed -i "2i $2 $3" $NOM.pgm
sed -i '3i 255' $NOM.pgm


