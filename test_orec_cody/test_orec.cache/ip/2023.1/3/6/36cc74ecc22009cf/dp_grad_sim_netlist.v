// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2023 Advanced Micro Devices, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2023.1 (lin64) Build 3865809 Sun May  7 15:04:56 MDT 2023
// Date        : Fri Jul 10 11:30:53 2026
// Host        : metal running 64-bit Ubuntu 22.04.5 LTS
// Command     : write_verilog -force -mode funcsim -rename_top decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix -prefix
//               decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_ dp_grad_sim_netlist.v
// Design      : dp_grad
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7z045ffg900-2
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
  (* C_READ_DEPTH_A = "2048" *) 
  (* C_READ_DEPTH_B = "2048" *) 
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
  (* C_WRITE_DEPTH_A = "2048" *) 
  (* C_WRITE_DEPTH_B = "2048" *) 
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
