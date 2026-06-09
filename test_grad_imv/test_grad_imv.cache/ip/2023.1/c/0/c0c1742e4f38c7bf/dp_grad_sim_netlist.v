// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2023 Advanced Micro Devices, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2023.1 (lin64) Build 3865809 Sun May  7 15:04:56 MDT 2023
// Date        : Wed Apr  9 10:45:17 2025
// Host        : metal running 64-bit Ubuntu 22.04.5 LTS
// Command     : write_verilog -force -mode funcsim -rename_top decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix -prefix
//               decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_ dp_grad_sim_netlist.v
// Design      : dp_grad
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7z045ffg900-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "dp_grad,blk_mem_gen_v8_4_6,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "blk_mem_gen_v8_4_6,Vivado 2023.1" *) 
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
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA DIN" *) input [15:0]dina;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTB CLK" *) (* x_interface_parameter = "XIL_INTERFACENAME BRAM_PORTB, MEM_SIZE 8192, MEM_WIDTH 32, MEM_ECC NONE, MASTER_TYPE OTHER, READ_LATENCY 1" *) input clkb;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTB ADDR" *) input [10:0]addrb;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTB DOUT" *) output [15:0]doutb;

  wire [10:0]addra;
  wire [10:0]addrb;
  wire clka;
  wire clkb;
  wire [15:0]dina;
  wire [15:0]doutb;
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
  wire [15:0]NLW_U0_douta_UNCONNECTED;
  wire [10:0]NLW_U0_rdaddrecc_UNCONNECTED;
  wire [3:0]NLW_U0_s_axi_bid_UNCONNECTED;
  wire [1:0]NLW_U0_s_axi_bresp_UNCONNECTED;
  wire [10:0]NLW_U0_s_axi_rdaddrecc_UNCONNECTED;
  wire [15:0]NLW_U0_s_axi_rdata_UNCONNECTED;
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
  (* C_COUNT_18K_BRAM = "0" *) 
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
  (* C_EST_POWER_SUMMARY = "Estimated Power for IP     :     4.7745 mW" *) 
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
  (* C_INIT_FILE = "dp_grad.mem" *) 
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
  (* C_READ_WIDTH_A = "16" *) 
  (* C_READ_WIDTH_B = "16" *) 
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
  (* C_WRITE_WIDTH_A = "16" *) 
  (* C_WRITE_WIDTH_B = "16" *) 
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
        .dinb({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .douta(NLW_U0_douta_UNCONNECTED[15:0]),
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
        .s_axi_rdata(NLW_U0_s_axi_rdata_UNCONNECTED[15:0]),
        .s_axi_rid(NLW_U0_s_axi_rid_UNCONNECTED[3:0]),
        .s_axi_rlast(NLW_U0_s_axi_rlast_UNCONNECTED),
        .s_axi_rready(1'b0),
        .s_axi_rresp(NLW_U0_s_axi_rresp_UNCONNECTED[1:0]),
        .s_axi_rvalid(NLW_U0_s_axi_rvalid_UNCONNECTED),
        .s_axi_sbiterr(NLW_U0_s_axi_sbiterr_UNCONNECTED),
        .s_axi_wdata({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
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
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 27472)
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
