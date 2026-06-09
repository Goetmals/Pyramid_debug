# Synplicity, Inc. constraint file
# i:\orec-ii\etc\xc_mire.sdc
# Written on Thu Dec 20 11:18:39 2001
# by 6.2 Scope Editor

#
# Clocks
#
define_clock          {n:gresetb} -freq 40.000
define_clock          {CLK_QUARTZ} -freq 40.000
define_clock          {n:gclk40mhz} -freq 40.000
define_clock          {n:clk108mhz} -freq 108.000
define_clock          {n:gclk108mhz} -freq 108.000

#
# Clock to Clock
#

#
# Inputs/Outputs
#

#
# Registers
#

#
# Multi-Cycle Paths
#

#
# False Paths
#

#
# Attributes
#
define_attribute          {INTER0} xc_loc {AE22}
define_attribute          {INTER1} xc_loc {AE24}
define_attribute          {RESET} xc_loc {AF14}
define_attribute          {CLK_QUARTZ} xc_loc {AD14}
define_attribute          {DATA_CMOS[99:0]} xc_loc {F4,G5,C2,D2,D1,E2,E1,H7,H6,F2,G4,G3,F1,G1,H3,H2,J7,K7,H4,J6,J5,J4,J3,H1,J2,L7,K6,K5,K4,K3,J1,K1,L4,L6,L5,L2,L1,M7,M8,M4,M6,M5,M2,M1,N8,P8,N7,N5,N4,N1,P1,P3,P4,P5,P6,R7,R1,R2,R3,R4,R5,R6,T4,T1,T2,R8,T8,T6,T5,U6,U3,U4,T7,U7,U1,V1,V3,V4,V5,V7,V6,W1,Y1,W2,W4,W5,Y3,Y4,AA1,AA2,W7,W6,Y6,AA3,AA4,AB1,AB2,AC1,AC2,AD2}
define_attribute          {SELECT_WINDOW[9:0]} xc_loc {A17,A16,A15,A14,A13,A12,A11,A10,A9,A8}
define_attribute          {SELECT_OREC[2:0]} xc_loc {AF10,AF9,AF8}
define_attribute          {SELECT_MODE[1:0]} xc_loc {A22,A21}
define_attribute          {CLK_DVI} xc_loc {AB14}
define_attribute          {SYSCLK_CMOS} xc_loc {AB13}
define_attribute          {ROW_ADDR_CMOS[9:0]} xc_loc {D6,C6,B1,A2,A3,G6,G7,E6,E7,B4}
define_attribute          {DATA_READ_ENN_CMOS} xc_loc {B26}
define_attribute          {LD_SHIFTN_CMOS} xc_loc {C26}
define_attribute          {CAL_STRST_CMOS} xc_loc {C25}
define_attribute          {ROW_STRTN_CMOS} xc_loc {E23}
define_attribute          {DARK_OFF_ENN_CMOS} xc_loc {E24}
define_attribute          {STANDBYN_CMOS} xc_loc {G21}
define_attribute          {LRSTN_CMOS} xc_loc {G22}
define_attribute          {PGN_CMOS} xc_loc {D26}
define_attribute          {TXN_CMOS} xc_loc {E26}
define_attribute          {ROW_DONEN_CMOS} xc_loc {G19}
define_attribute          {DIE[23:0]} xc_loc {M26,L26,L25,L23,L22,L21,L20,L19,K24,K23,K21,K20,J26,J25,J24,J23,J22,J21,J20,H26,H25,H23,H22,H21}
define_attribute          {DIO[23:0]} xc_loc {W26,V25,V24,V23,V22,V21,V20,U26,U24,U21,T23,T22,T21,T19,R26,R25,R23,R22,R21,R20,R19,P22,P21,P20}
define_attribute          {DE} xc_loc {P26}
define_attribute          {HSYNCH} xc_loc {P23}
define_attribute          {VSYNCH} xc_loc {N19}
define_attribute          {CTL1} xc_loc {T26}
define_attribute          {CTL2} xc_loc {T25}
define_attribute          {CTL3} xc_loc {T20}
define_attribute          {EDGE} xc_loc {U23}
define_attribute          {PIXS} xc_loc {V26}
define_attribute          {PD} xc_loc {Y26}
define_attribute          {LED} xc_loc {AE18}
define_global_attribute          xc_fast_auto {1}
define_global_attribute          syn_useioff {1}

#
# Other Constraints
#
