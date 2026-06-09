#!/bin/sh
#- ========================================================================== --
#-
#- Fichier   :	test_orec-II.pl
#-
#- Auteur    :	Philippe Lamaty, Jérome Michel
#-
#- Copyright :	AEROSPATIALE MATRA Missiles 1998-2001
#-
#- -------------------------------------------------------------------------- --
#- Modification :
#-
#-	Auteur		Date		Version		Commentaire
#-
#-	p.Lamaty	11.01.2002	1.0		création
#-	j.Michel	    "		 "		    "
#-
#- -------------------------------------------------------------------------- --
#- Rôle :
#-
#- lance une campagne de test 
#-
#- ========================================================================== --
#perl -wSx $0 ${1+"$@"}
#exit

# __BEGIN__
# ============================================================================ #
#!perl

print "coucou\n";
print "coucou\n";
print "coucou\n";
print "coucou\n";
print "coucou\n";
print "coucou\n";
print "coucou\n";
print "coucou\n";

open(FDST,">messages.coe");
$v = "";
print FDST "MEMORY_INITIALIZATION_RADIX=2;\n";
print FDST "MEMORY_INITIALIZATION_VECTOR=\n";
for ( $i = 0; $i < 16384; $i++ ) {
	print FDST "$v 1";
	$v = ",";

}
print FDST ";\n";
close(FDST);

# ============================================================================ #
__END__
