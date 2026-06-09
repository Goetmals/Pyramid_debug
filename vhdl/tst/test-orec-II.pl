#!/bin/sh
#- ========================================================================== --
#-
#- Fichier   :	test_orec-II.pl
#-
#- Auteur    :	Philippe Lamaty
#-
#- Copyright :	AEROSPATIALE MATRA Missiles 1998-2001
#-
#- -------------------------------------------------------------------------- --
#- Modification :
#-
#-	Auteur		Date		Version		Commentaire
#-
#-	p.Lamaty	24.07.2001	1.0		création
#-
#- -------------------------------------------------------------------------- --
#- Rôle :
#-
#- lance une campagne de test 
#-
#- ========================================================================== --
perl -wSx $0 ${1+"$@"}
exit

# __BEGIN__
# ============================================================================ #
#!perl

# liste des tests à effectuer
# ---------------------------------------------------------------------------- #
@tests =(#"./tst/ImageTests/cube.imv:0:2,7,15,25,36,43:63:2,7"
	#,"./tst/ImageTests/cube.imv:1:2,7,15,25,36,43:63:2,7"
	#,"./tst/ImageTests/cube.imv:2:2,7,15,25,36,43:63:2,7"
	#,"./tst/ImageTests/cube.imv:3:2,7,15,25,36,43:63:2,7"
	#,"./tst/ImageTests/cube.imv:4:2,7,15,25,36,43:63:2,7"
	#,"./tst/ImageTests/ima_3.imv:5:2,7,15,25,36,43:63:2,7"
	#"./tst/ImageTests/cube.imv:6:2,7,15,25,36,43:63:2,7"
	"./tst/ImageTests/bloc.imv:7:2,7,15,25,36,43:63:2,4"
	#,"./tst/ImageTests/bloc.imv:0:2,7,15,25,36,43:63:2,7"
	#,"./tst/ImageTests/bloc.imv:1:2,7,15,25,36,43:63:2,7"
	#,"./tst/ImageTests/bloc.imv:2:2,7,15,25,36,43:63:2,7"
	#,"./tst/ImageTests/bloc.imv:3:2,7,15,25,36,43:63:2,7"
	#,"./tst/ImageTests/bloc.imv:4:2,7,15,25,36,43:63:2,7"
	#,"./tst/ImageTests/bloc.imv:5:2,7,15,25,36,43:63:2,7"
	#,"./tst/ImageTests/bloc.imv:6:2,7,15,25,36,43:63:2,7"
	#,"./tst/ImageTests/bloc.imv:7:2,7,15,25,36,43:63:2,7"
	);

# ---------------------------------------------------------------------------- #
$orec	= "/users/suete1_a/lamaty/src/orec-II/orec-II";
$tetard	= "/users/suete1_a/lamaty/tcltk/tetard";

# ---------------------------------------------------------------------------- #
$ftst	= "./tst/test_orec.vhd";
$fvhd	= "./tst/ImageTests/result.vhd.imv";
$fccc	= "./tst/ImageTests/result.c.imv";


# on remplace les coefficients de convolution
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ #
sub substSLV {
	$_[0] =~ s/$_[1]\s*<=\s*conv_std_logic_vector\(\s*\d*/$_[1] <= conv_std_logic_vector\( $_[2]/g;
	return $_[0];
}

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ #
sub substFILE {
	if ( $_[0] =~ /$_[1]\s+:/ ) {
		$_ = $_[0];
		($value) = /:= "([A-Za-z0-9_\/.]+)"/;
		$_[0] =~ s/$value/$_[2]/;
	}

	return $_[0];
}

# lecture du fichier
# ---------------------------------------------------------------------------- #

open(FSRC,$ftst);
@lignes = <FSRC>;
close(FSRC);

open(FDST,">$ftst%");
print FDST @lignes;
close(FDST);

# Pour chaque test
# ---------------------------------------------------------------------------- #
for ( $n = 0; $n < @tests; $n++ ) {

	# décodage des données du test
	# ------------------------------------------------------------ #
	$_ = $tests[$n];
	($finn
	,$mode
	,$csin[0],$csin[1],$csin[2],$csin[3],$csin[4],$csin[5]
	,$campl
	,$sb,$sh
	) = 
	/([A-Za-z0-9_\/.]+):(\d+):(\d+),(\d+),(\d+),(\d+),(\d+),(\d+):(\d+):(\d+),(\d+)/;

	# modification du fichier vhdl de test
	# ------------------------------------------------------------ #
	for ( $i = 0; $i < @lignes; $i++ ) {
		$lignes[$i] = substFILE( $lignes[$i],"nomSrce",$finn );
		$lignes[$i] = substFILE( $lignes[$i],"nomDest",$fvhd );

		$lignes[$i] = substSLV( $lignes[$i],"csin0",$csin[0] );
		$lignes[$i] = substSLV( $lignes[$i],"csin1",$csin[1] );
		$lignes[$i] = substSLV( $lignes[$i],"csin2",$csin[2] );
		$lignes[$i] = substSLV( $lignes[$i],"csin3",$csin[3] );
		$lignes[$i] = substSLV( $lignes[$i],"csin4",$csin[4] );
		$lignes[$i] = substSLV( $lignes[$i],"csin5",$csin[5] );

		$lignes[$i] = substSLV( $lignes[$i],"camp ",$campl );

		$lignes[$i] = substSLV( $lignes[$i],"seuil_bas ",$sb );
		$lignes[$i] = substSLV( $lignes[$i],"seuil_haut",$sh );

		$lignes[$i] = substSLV( $lignes[$i],"mode ",$mode );
	}

	open(FDST,">$ftst");
	print FDST @lignes;
	close(FDST);

	# ------------------------------------------------------------ #
	$cs = "$csin[0],$csin[1],$csin[2],$csin[3],$csin[4],$csin[5]";

	print "\n";
	print "-- ----------------------------------------------- --\n";
	print "- I -	Analyse $finn\n";
	print "		mode =$mode\n";
	print "		csin =$cs\n";
	print "		campl=$campl\n";
	print "		sb,sh=$sb,$sh\n";

	# résultat obtenu à partir du C
	# ------------------------------------------------------------ #
	print "- I -	Simulation C\n";
#	print "$orec -mode=$mode -csin=$cs -ampl=$campl -sb=$sb -sh=$sh -fs $finn -fd $fccc\n";
	`$orec -mode=$mode -csin=$cs -ampl=$campl -sb=$sb -sh=$sh -fs $finn -fd $fccc`;

	# résultat obtenu après simulation vhdl
	# ------------------------------------------------------------ #
	print "- I -	Simulation HDL\n";
print	`$tetard --batch=test_orec 2> /dev/null 1> /dev/null`;
#print	`$tetard --batch=test_orec`;

	# comparaison des résultats obtenus
	# ------------------------------------------------------------ #
#print `diff $fccc $fvhd`;
	$errno = system("cmp $fccc $fvhd 2> /dev/null 1> /dev/null");

	if ( $errno ) {
		print "- E -	C & HDL images are differents\n";
		exit -1
	}
	print "- = -	Les images C & HDL sont identiques\n";
}


# ============================================================================ #
__END__
