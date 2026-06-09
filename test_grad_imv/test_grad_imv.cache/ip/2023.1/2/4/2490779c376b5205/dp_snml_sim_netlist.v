// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2023 Advanced Micro Devices, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2023.1 (lin64) Build 3865809 Sun May  7 15:04:56 MDT 2023
// Date        : Wed Apr  9 10:45:17 2025
// Host        : metal running 64-bit Ubuntu 22.04.5 LTS
// Command     : write_verilog -force -mode funcsim -rename_top decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix -prefix
//               decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_ dp_snml_sim_netlist.v
// Design      : dp_snml
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7z045ffg900-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "dp_snml,blk_mem_gen_v8_4_6,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "blk_mem_gen_v8_4_6,Vivado 2023.1" *) 
(* NotValidForBitStream *)
module decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix
   (clka,
    wea,
    addra,
    dina,
    clkb,
    addrb,
    doutb);
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA CLK" *) (* x_interface_parameter = "XIL_INTERFACENAME BRAM_PORTA, MEM_SIZE 8192, MEM_WIDTH 32, MEM_ECC NONE, MASTER_TYPE OTHER, READ_LATENCY 1" *) input clka;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA WE" *) input [0:0]wea;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA ADDR" *) input [10:0]addra;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA DIN" *) input [21:0]dina;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTB CLK" *) (* x_interface_parameter = "XIL_INTERFACENAME BRAM_PORTB, MEM_SIZE 8192, MEM_WIDTH 32, MEM_ECC NONE, MASTER_TYPE OTHER, READ_LATENCY 1" *) input clkb;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTB ADDR" *) input [10:0]addrb;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTB DOUT" *) output [21:0]doutb;

  wire [10:0]addra;
  wire [10:0]addrb;
  wire clka;
  wire clkb;
  wire [21:0]dina;
  wire [21:0]doutb;
  wire [0:0]wea;
  wire NLW_U0_dbiterr_UNCONNECTED;
  wire NLW_U0_rsta_busy_UNCONNECTED;
  wire NLW_U0_rstb_busy_UNCONNECTED;
  wire NLW_U0_s_axi_arready_UNCONNECTED;
  wire NLW_U0_s_axi_awready_UNCONNECTED;
  wire NLW_U0_s_axi_bvalid_UNCONNECTED;
  wire NLW_U0_s_axi_dbiterr_UNCONNECTED;
  wire NLW_U0_s_axi_rlast_UNCONNECTED;
  wire NLW_U0_s_axi_rvalid_UNCONNECTED;
  wire NLW_U0_s_axi_sbiterr_UNCONNECTED;
  wire NLW_U0_s_axi_wready_UNCONNECTED;
  wire NLW_U0_sbiterr_UNCONNECTED;
  wire [21:0]NLW_U0_douta_UNCONNECTED;
  wire [10:0]NLW_U0_rdaddrecc_UNCONNECTED;
  wire [3:0]NLW_U0_s_axi_bid_UNCONNECTED;
  wire [1:0]NLW_U0_s_axi_bresp_UNCONNECTED;
  wire [10:0]NLW_U0_s_axi_rdaddrecc_UNCONNECTED;
  wire [21:0]NLW_U0_s_axi_rdata_UNCONNECTED;
  wire [3:0]NLW_U0_s_axi_rid_UNCONNECTED;
  wire [1:0]NLW_U0_s_axi_rresp_UNCONNECTED;

  (* C_ADDRA_WIDTH = "11" *) 
  (* C_ADDRB_WIDTH = "11" *) 
  (* C_ALGORITHM = "1" *) 
  (* C_AXI_ID_WIDTH = "4" *) 
  (* C_AXI_SLAVE_TYPE = "0" *) 
  (* C_AXI_TYPE = "1" *) 
  (* C_BYTE_SIZE = "9" *) 
  (* C_COMMON_CLK = "0" *) 
  (* C_COUNT_18K_BRAM = "1" *) 
  (* C_COUNT_36K_BRAM = "1" *) 
  (* C_CTRL_ECC_ALGO = "NONE" *) 
  (* C_DEFAULT_DATA = "0" *) 
  (* C_DISABLE_WARN_BHV_COLL = "0" *) 
  (* C_DISABLE_WARN_BHV_RANGE = "0" *) 
  (* C_ELABORATION_DIR = "./" *) 
  (* C_ENABLE_32BIT_ADDRESS = "0" *) 
  (* C_EN_DEEPSLEEP_PIN = "0" *) 
  (* C_EN_ECC_PIPE = "0" *) 
  (* C_EN_RDADDRA_CHG = "0" *) 
  (* C_EN_RDADDRB_CHG = "0" *) 
  (* C_EN_SAFETY_CKT = "0" *) 
  (* C_EN_SHUTDOWN_PIN = "0" *) 
  (* C_EN_SLEEP_PIN = "0" *) 
  (* C_EST_POWER_SUMMARY = "Estimated Power for IP     :     7.1298 mW" *) 
  (* C_FAMILY = "zynq" *) 
  (* C_HAS_AXI_ID = "0" *) 
  (* C_HAS_ENA = "0" *) 
  (* C_HAS_ENB = "0" *) 
  (* C_HAS_INJECTERR = "0" *) 
  (* C_HAS_MEM_OUTPUT_REGS_A = "0" *) 
  (* C_HAS_MEM_OUTPUT_REGS_B = "1" *) 
  (* C_HAS_MUX_OUTPUT_REGS_A = "0" *) 
  (* C_HAS_MUX_OUTPUT_REGS_B = "0" *) 
  (* C_HAS_REGCEA = "0" *) 
  (* C_HAS_REGCEB = "0" *) 
  (* C_HAS_RSTA = "0" *) 
  (* C_HAS_RSTB = "0" *) 
  (* C_HAS_SOFTECC_INPUT_REGS_A = "0" *) 
  (* C_HAS_SOFTECC_OUTPUT_REGS_B = "0" *) 
  (* C_INITA_VAL = "0" *) 
  (* C_INITB_VAL = "0" *) 
  (* C_INIT_FILE = "dp_snml.mem" *) 
  (* C_INIT_FILE_NAME = "no_coe_file_loaded" *) 
  (* C_INTERFACE_TYPE = "0" *) 
  (* C_LOAD_INIT_FILE = "0" *) 
  (* C_MEM_TYPE = "1" *) 
  (* C_MUX_PIPELINE_STAGES = "0" *) 
  (* C_PRIM_TYPE = "1" *) 
  (* C_READ_DEPTH_A = "1280" *) 
  (* C_READ_DEPTH_B = "1280" *) 
  (* C_READ_LATENCY_A = "1" *) 
  (* C_READ_LATENCY_B = "1" *) 
  (* C_READ_WIDTH_A = "22" *) 
  (* C_READ_WIDTH_B = "22" *) 
  (* C_RSTRAM_A = "0" *) 
  (* C_RSTRAM_B = "0" *) 
  (* C_RST_PRIORITY_A = "CE" *) 
  (* C_RST_PRIORITY_B = "CE" *) 
  (* C_SIM_COLLISION_CHECK = "ALL" *) 
  (* C_USE_BRAM_BLOCK = "0" *) 
  (* C_USE_BYTE_WEA = "0" *) 
  (* C_USE_BYTE_WEB = "0" *) 
  (* C_USE_DEFAULT_DATA = "0" *) 
  (* C_USE_ECC = "0" *) 
  (* C_USE_SOFTECC = "0" *) 
  (* C_USE_URAM = "0" *) 
  (* C_WEA_WIDTH = "1" *) 
  (* C_WEB_WIDTH = "1" *) 
  (* C_WRITE_DEPTH_A = "1280" *) 
  (* C_WRITE_DEPTH_B = "1280" *) 
  (* C_WRITE_MODE_A = "NO_CHANGE" *) 
  (* C_WRITE_MODE_B = "WRITE_FIRST" *) 
  (* C_WRITE_WIDTH_A = "22" *) 
  (* C_WRITE_WIDTH_B = "22" *) 
  (* C_XDEVICEFAMILY = "zynq" *) 
  (* downgradeipidentifiedwarnings = "yes" *) 
  (* is_du_within_envelope = "true" *) 
  decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_blk_mem_gen_v8_4_6 U0
       (.addra(addra),
        .addrb(addrb),
        .clka(clka),
        .clkb(clkb),
        .dbiterr(NLW_U0_dbiterr_UNCONNECTED),
        .deepsleep(1'b0),
        .dina(dina),
        .dinb({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .douta(NLW_U0_douta_UNCONNECTED[21:0]),
        .doutb(doutb),
        .eccpipece(1'b0),
        .ena(1'b0),
        .enb(1'b0),
        .injectdbiterr(1'b0),
        .injectsbiterr(1'b0),
        .rdaddrecc(NLW_U0_rdaddrecc_UNCONNECTED[10:0]),
        .regcea(1'b0),
        .regceb(1'b0),
        .rsta(1'b0),
        .rsta_busy(NLW_U0_rsta_busy_UNCONNECTED),
        .rstb(1'b0),
        .rstb_busy(NLW_U0_rstb_busy_UNCONNECTED),
        .s_aclk(1'b0),
        .s_aresetn(1'b0),
        .s_axi_araddr({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_arburst({1'b0,1'b0}),
        .s_axi_arid({1'b0,1'b0,1'b0,1'b0}),
        .s_axi_arlen({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_arready(NLW_U0_s_axi_arready_UNCONNECTED),
        .s_axi_arsize({1'b0,1'b0,1'b0}),
        .s_axi_arvalid(1'b0),
        .s_axi_awaddr({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_awburst({1'b0,1'b0}),
        .s_axi_awid({1'b0,1'b0,1'b0,1'b0}),
        .s_axi_awlen({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_awready(NLW_U0_s_axi_awready_UNCONNECTED),
        .s_axi_awsize({1'b0,1'b0,1'b0}),
        .s_axi_awvalid(1'b0),
        .s_axi_bid(NLW_U0_s_axi_bid_UNCONNECTED[3:0]),
        .s_axi_bready(1'b0),
        .s_axi_bresp(NLW_U0_s_axi_bresp_UNCONNECTED[1:0]),
        .s_axi_bvalid(NLW_U0_s_axi_bvalid_UNCONNECTED),
        .s_axi_dbiterr(NLW_U0_s_axi_dbiterr_UNCONNECTED),
        .s_axi_injectdbiterr(1'b0),
        .s_axi_injectsbiterr(1'b0),
        .s_axi_rdaddrecc(NLW_U0_s_axi_rdaddrecc_UNCONNECTED[10:0]),
        .s_axi_rdata(NLW_U0_s_axi_rdata_UNCONNECTED[21:0]),
        .s_axi_rid(NLW_U0_s_axi_rid_UNCONNECTED[3:0]),
        .s_axi_rlast(NLW_U0_s_axi_rlast_UNCONNECTED),
        .s_axi_rready(1'b0),
        .s_axi_rresp(NLW_U0_s_axi_rresp_UNCONNECTED[1:0]),
        .s_axi_rvalid(NLW_U0_s_axi_rvalid_UNCONNECTED),
        .s_axi_sbiterr(NLW_U0_s_axi_sbiterr_UNCONNECTED),
        .s_axi_wdata({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_wlast(1'b0),
        .s_axi_wready(NLW_U0_s_axi_wready_UNCONNECTED),
        .s_axi_wstrb(1'b0),
        .s_axi_wvalid(1'b0),
        .sbiterr(NLW_U0_sbiterr_UNCONNECTED),
        .shutdown(1'b0),
        .sleep(1'b0),
        .wea(wea),
        .web(1'b0));
endmodule
`pragma protect begin_protected
`pragma protect version = 1
`pragma protect encrypt_agent = "XILINX"
`pragma protect encrypt_agent_info = "Xilinx Encryption Tool 2023.1"
`pragma protect key_keyowner="Synopsys", key_keyname="SNPS-VCS-RSA-2", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=128)
`pragma protect key_block
aMT3usC6uizzcwnzOCX4OsS16Ob+YxFcsGovFpFklbnaIaD1S0lVdxenTwHPp6ByIEi+ehwr6Rgg
z/3AlTheI5NFTM8ihiMA18/wmUxI7EbaftJACA1LykUKCuj5myy0T+DACuv3sGYIZS38TZTZnnBC
FGAlvTZmRWs+JzneH3o=

`pragma protect key_keyowner="Aldec", key_keyname="ALDEC15_001", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
lR9ZerhYSAb39nzEkeYvhnwEs5t9y/+yTDf8KuoUtR1BGeHZq8pA/YxtjzQLtaOW1R1IQUb0FtSI
e3CYAb7WHYbIjcpw3vKHvW1SqcGn9CMGa556CYKmD2oF12Kow8xRaFvMSBUVxX7HsHxNWnRd+PU1
+C0YayU2KFIY/7Yl6cZ5luAzhw/6SW3PFYUIyyqWy5MCIXweHOwQR2IpQEdlDur5nluN7i7BeB+i
fxwwHh8TU/g7T4mhZFkiTuBKdLAtQOjxWxzqTMxgcuAjlTylY16FgMFOASdvvSbqBZJjbxMdVloU
rYjS8O/8rWktv8GXcaIdBJ2BRj01q7jsChsbwA==

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-VELOCE-RSA", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=128)
`pragma protect key_block
Qvl63GHz9mq2xOB7elt/vAQ7URLGdD1Lkcz7f3Wtw31dwjjjbP62Ny/Jr6OmBIheWlgejx38qxAT
TrHiiEyjKmGcnPn1Tn2n+cH4RAxCbOFnCI9n6+YsYMTe9JkplGhGGr39SkFgJz0I2IKpPsuqTjCj
rhf49TAryNMQeRpREJA=

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-VERIF-SIM-RSA-2", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
MA+9Ro+dh339m0iZrkKbqTKN8gQ5xkxN/SPCfhkOn+5jjgCTS5IOKLHil+HsZDjX333ebxnornwG
MOBxyEdFfLM8SA+bs2r41J/j0af2VVMmCM3hOh8JmZxB4X9Jg/glegNCbvwzqxMbOQNEy+zt7j5t
TFVD82RtPFmYVVYZZyll/WvAA+0aVpyjzLCIM1GznFky0RWLv65Wp4MJJnNRRrtG3muMznVO/u2s
tACsJ9jzv9M0IlMYjYH9BixhG6cZX02I4LEXXaPkhdOINlMMhsbArXtc9NphzmS4bY1/1yF1D6YD
EKLyS2Sr3HDl0O/lefN+jvfG8iKuVl55PNNrVQ==

`pragma protect key_keyowner="Real Intent", key_keyname="RI-RSA-KEY-1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
wpMTg7STjFkUDhOqdNPa0FHXTnHQgKmhvqDv+rRVBvMiQ8O7u8oj7ibITq3o+jugJsMJ60B410gQ
JFTcqCJKYmYJvqi8rPLLOYDmFG6ZLP/Ixr3n62IyIaCeDltBahi3yV009QN0X+iuzuFCL+Y7g9ff
IvAgyBly+Z3Itv2H9EJMZPMl17Sa7IkgjmWqzVXIKNMKn0iDVYsQw6ZgzQDYQ8N8IvTIEggU3/lh
6Nf0hV0ev3qOv/2P+4w0U766Ux3yLuzPJSI7bKm3/ip9NjhOytxOiKKqVXhKG8dzbbuS5u3EE/eq
q6YxkL7gpvNltVqqBnJB6vHSyWrD6+MqsCtR9A==

`pragma protect key_keyowner="Xilinx", key_keyname="xilinxt_2022_10", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
Q7Q4SSp70lxFryaopuic9VVP/Ire0pSsPEIMYdURBAczC7ShkuYeV02U7L3BlAiyBE4vBKcwYSQd
cWiaj8sVP7q4kxoRHKxLV1R5PIO6l4DsLWE2E+1MLyUPME0w5KTular/oX8EPCJ5n/8VCtW7x4Vf
dpeyki1/IAPJkAyi3zVZKHzgKhEwnZaZZtZYuMWoPZMt4V38sAcE42Raf+7yfFWG5HO74JY6iEnW
gJeRk58K+avB/XLF2/j2RQZfjTYizrprT2tUMBK6e7DRWZZtk8AOcsMhUikev44IFGNbNXjP8BXC
0J3y3P7pCFT6l+saU83nRwi/H25fSA34diJtNw==

`pragma protect key_keyowner="Metrics Technologies Inc.", key_keyname="DSim", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
a/8ooC+s+6nfvfa1+oBhsvYWLJjFgp83DI1kNyOi5Am+ugPbGRmgGZudfyo6yw6Yd5gGbLm5aToQ
5G4cGF5HaXD5TU6A0ZZFMTIbzFLE76JMjjIxX8JcaJIZpSmrXqlru8l5gDINUEAmwUY3mRQnjcGJ
0Z+kMRH8iAEF+gEviPiFZSBbJeOPqivIS217kimQJX3BeNbNPQTP+GUidcRywpGMh5avxtA0kDRO
F9SoCSyTm9hr2v9hsK1IUAYQLb7n2/R+z5YNKNzt1oN4qgJH1wZfdI8if2K8+ohyOdnxrrgJOWdj
cOqr7cGqEOYfBMTIQeHVZzb7NGWVN+9B8XSUaQ==

`pragma protect key_keyowner="Atrenta", key_keyname="ATR-SG-RSA-1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=384)
`pragma protect key_block
FLPvOUNRWNW2GU+FEGmt2XWthOT5bY/31DRbol2cUmEGNF6b2XzpCosNKGx/o2n6sQvGP39KRFCs
nJu0ihe2dUGee9nEZZUcpwPjnEfXVI3yJaRVYy8iL+rm59lXq0jX4sjAPieDvv8shgAnoXLTZGlq
K+2c1JhaHt+nFi27TDrYar/+P8nP1MhocOS7BjzCvSs0foEXj92/qD+71Sm/LqGr8cjlH2qTJJ8B
ynxoH6iT+bksVA2VbtPT9o6h1kJ/zwP4wcsL9l+qSlJhd4GI11JPux26DlNyIi41WmufQcfiT0PB
r6O9+0E9lV9ODwKdjaxfZRK29rjKeq2yr0jWhMV38XKKqHAJli7MIypGRXcCo+u89H87KgYt+ebw
s3foIqCe0JKR57WzI8VD6XdNtOL8eBxK539oemx4vkE0cGYECZKYru6A2hPeZOYDD5eyWSUlQl1R
EciK49WM8HnssyRVcmE6di6bISMbVi0TZG/v98bz+9UZa8DtqMVYH0tz

`pragma protect key_keyowner="Cadence Design Systems.", key_keyname="CDS_RSA_KEY_VER_1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
fphquQOeFuqByo36Gh2C1zEC1J6u9swSMbMzsKldIvLm+SZ6/hr/N8KJ/G2vBABzX6UtbVuP1ZXx
AxdftP4Aqis1B3Bs6989aQG9eo0SOHA7r6aFLtFb3qoD5Pvqw4aVNU4z4EtTpFpn/jCWD21lKROf
q5X32HRfFq1jwqod+9vIbUNRRzz5y9VHvXfacZlxDazSPmcCF4hxB1KqWqT44KmYVkDedgkgnYgb
ZGidHnTb3W7C8tSqC9ac4kNJCL429QndtddweESJNlpX+65pt9Irok9pkOodwoj0QScswOIFjhBZ
/GrzZLQcFWiD3gXRU4DazzxQnGdRH4qEIRWziw==

`pragma protect key_keyowner="Synplicity", key_keyname="SYNP15_1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
1lUYYHPCt1BUJOvcBbgMU2GSQiqfxItz4ntieMaenjrtsE9SLwaU6xB0tBl8Atw5yP/RRNww1kX/
9uZbTz5He3r9mPVt+mGxB4N3f9BbCrQRb4USVPgKO/+vWUfMQERGklScy0+fz75WuxH74CjRUoDI
8iyssb2cUNnfDe13jIoI8gM1w4w/Pkxkmb6Mef53QMxacHAWEZeytcH3fuL/adO263D8P90U3XJv
vBXJmbjkRVi9qzjBzfMxuOy2KbZaZgR3BLzaffIfFnMwg/Rb8sGls5pQsZv5jL2wk3+Bj3OXBYdd
pDyjGoalJBzObKzd/t15kNHwY4FXYFcZLQPncw==

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-PREC-RSA", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
YRmSEzaa2WFVvMH1BwWc1TIUpVbzSEIP0VbI6n0sEgct/X4PiTfMQmK1jBVCaISIzwBxscKQwZOt
mb/nmINGg6I7ih39LSbBMtx6cdCUiyaLkPeRbqfyPpKhvnUIFmdKVvTd1dYzxeOeuDnhSVaBaAcN
3lngSg7lIbmhLIGjC29yQrBTiLArbVZi6IRGronMK51e3UrYa6GspsznhiuRcXjEb4bHKrJ2CM5Z
BUwA+E9949sQgyOagFZbLVle2ESbwBaoxcAPn2gxfRHlT0leqyLgUGDZLsfArzGzw9BTGzyEG2TR
XOrKFNYRfMXMrnGsBM7acIelY4LdAMgsKgDH/A==

`pragma protect data_method = "AES128-CBC"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 38240)
`pragma protect data_block
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
`pragma protect end_protected
`ifndef GLBL
`define GLBL
`timescale  1 ps / 1 ps

module glbl ();

    parameter ROC_WIDTH = 100000;
    parameter TOC_WIDTH = 0;
    parameter GRES_WIDTH = 10000;
    parameter GRES_START = 10000;

//--------   STARTUP Globals --------------
    wire GSR;
    wire GTS;
    wire GWE;
    wire PRLD;
    wire GRESTORE;
    tri1 p_up_tmp;
    tri (weak1, strong0) PLL_LOCKG = p_up_tmp;

    wire PROGB_GLBL;
    wire CCLKO_GLBL;
    wire FCSBO_GLBL;
    wire [3:0] DO_GLBL;
    wire [3:0] DI_GLBL;
   
    reg GSR_int;
    reg GTS_int;
    reg PRLD_int;
    reg GRESTORE_int;

//--------   JTAG Globals --------------
    wire JTAG_TDO_GLBL;
    wire JTAG_TCK_GLBL;
    wire JTAG_TDI_GLBL;
    wire JTAG_TMS_GLBL;
    wire JTAG_TRST_GLBL;

    reg JTAG_CAPTURE_GLBL;
    reg JTAG_RESET_GLBL;
    reg JTAG_SHIFT_GLBL;
    reg JTAG_UPDATE_GLBL;
    reg JTAG_RUNTEST_GLBL;

    reg JTAG_SEL1_GLBL = 0;
    reg JTAG_SEL2_GLBL = 0 ;
    reg JTAG_SEL3_GLBL = 0;
    reg JTAG_SEL4_GLBL = 0;

    reg JTAG_USER_TDO1_GLBL = 1'bz;
    reg JTAG_USER_TDO2_GLBL = 1'bz;
    reg JTAG_USER_TDO3_GLBL = 1'bz;
    reg JTAG_USER_TDO4_GLBL = 1'bz;

    assign (strong1, weak0) GSR = GSR_int;
    assign (strong1, weak0) GTS = GTS_int;
    assign (weak1, weak0) PRLD = PRLD_int;
    assign (strong1, weak0) GRESTORE = GRESTORE_int;

    initial begin
	GSR_int = 1'b1;
	PRLD_int = 1'b1;
	#(ROC_WIDTH)
	GSR_int = 1'b0;
	PRLD_int = 1'b0;
    end

    initial begin
	GTS_int = 1'b1;
	#(TOC_WIDTH)
	GTS_int = 1'b0;
    end

    initial begin 
	GRESTORE_int = 1'b0;
	#(GRES_START);
	GRESTORE_int = 1'b1;
	#(GRES_WIDTH);
	GRESTORE_int = 1'b0;
    end

endmodule
`endif
