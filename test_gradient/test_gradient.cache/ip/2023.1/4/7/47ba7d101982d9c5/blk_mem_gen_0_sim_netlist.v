// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2023 Advanced Micro Devices, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2023.1 (lin64) Build 3865809 Sun May  7 15:04:56 MDT 2023
// Date        : Thu Jul  2 13:26:30 2026
// Host        : metal running 64-bit Ubuntu 22.04.5 LTS
// Command     : write_verilog -force -mode funcsim -rename_top decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix -prefix
//               decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_ blk_mem_gen_0_sim_netlist.v
// Design      : blk_mem_gen_0
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7z045ffg900-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "blk_mem_gen_0,blk_mem_gen_v8_4_6,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "blk_mem_gen_v8_4_6,Vivado 2023.1" *) 
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
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA ADDR" *) input [8:0]addra;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA DIN" *) input [7:0]dina;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTB CLK" *) (* x_interface_parameter = "XIL_INTERFACENAME BRAM_PORTB, MEM_SIZE 8192, MEM_WIDTH 32, MEM_ECC NONE, MASTER_TYPE OTHER, READ_LATENCY 1" *) input clkb;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTB ADDR" *) input [8:0]addrb;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTB DOUT" *) output [7:0]doutb;

  wire [8:0]addra;
  wire [8:0]addrb;
  wire clka;
  wire [7:0]dina;
  wire [7:0]doutb;
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
  wire [7:0]NLW_U0_douta_UNCONNECTED;
  wire [8:0]NLW_U0_rdaddrecc_UNCONNECTED;
  wire [3:0]NLW_U0_s_axi_bid_UNCONNECTED;
  wire [1:0]NLW_U0_s_axi_bresp_UNCONNECTED;
  wire [8:0]NLW_U0_s_axi_rdaddrecc_UNCONNECTED;
  wire [7:0]NLW_U0_s_axi_rdata_UNCONNECTED;
  wire [3:0]NLW_U0_s_axi_rid_UNCONNECTED;
  wire [1:0]NLW_U0_s_axi_rresp_UNCONNECTED;

  (* C_ADDRA_WIDTH = "9" *) 
  (* C_ADDRB_WIDTH = "9" *) 
  (* C_ALGORITHM = "1" *) 
  (* C_AXI_ID_WIDTH = "4" *) 
  (* C_AXI_SLAVE_TYPE = "0" *) 
  (* C_AXI_TYPE = "1" *) 
  (* C_BYTE_SIZE = "9" *) 
  (* C_COMMON_CLK = "1" *) 
  (* C_COUNT_18K_BRAM = "1" *) 
  (* C_COUNT_36K_BRAM = "0" *) 
  (* C_CTRL_ECC_ALGO = "NONE" *) 
  (* C_DEFAULT_DATA = "0" *) 
  (* C_DISABLE_WARN_BHV_COLL = "1" *) 
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
  (* C_EST_POWER_SUMMARY = "Estimated Power for IP     :     2.68455 mW" *) 
  (* C_FAMILY = "zynq" *) 
  (* C_HAS_AXI_ID = "0" *) 
  (* C_HAS_ENA = "0" *) 
  (* C_HAS_ENB = "0" *) 
  (* C_HAS_INJECTERR = "0" *) 
  (* C_HAS_MEM_OUTPUT_REGS_A = "0" *) 
  (* C_HAS_MEM_OUTPUT_REGS_B = "0" *) 
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
  (* C_INIT_FILE = "blk_mem_gen_0.mem" *) 
  (* C_INIT_FILE_NAME = "no_coe_file_loaded" *) 
  (* C_INTERFACE_TYPE = "0" *) 
  (* C_LOAD_INIT_FILE = "0" *) 
  (* C_MEM_TYPE = "1" *) 
  (* C_MUX_PIPELINE_STAGES = "0" *) 
  (* C_PRIM_TYPE = "1" *) 
  (* C_READ_DEPTH_A = "512" *) 
  (* C_READ_DEPTH_B = "512" *) 
  (* C_READ_LATENCY_A = "1" *) 
  (* C_READ_LATENCY_B = "1" *) 
  (* C_READ_WIDTH_A = "8" *) 
  (* C_READ_WIDTH_B = "8" *) 
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
  (* C_WRITE_DEPTH_A = "512" *) 
  (* C_WRITE_DEPTH_B = "512" *) 
  (* C_WRITE_MODE_A = "NO_CHANGE" *) 
  (* C_WRITE_MODE_B = "READ_FIRST" *) 
  (* C_WRITE_WIDTH_A = "8" *) 
  (* C_WRITE_WIDTH_B = "8" *) 
  (* C_XDEVICEFAMILY = "zynq" *) 
  (* downgradeipidentifiedwarnings = "yes" *) 
  (* is_du_within_envelope = "true" *) 
  decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_blk_mem_gen_v8_4_6 U0
       (.addra(addra),
        .addrb(addrb),
        .clka(clka),
        .clkb(1'b0),
        .dbiterr(NLW_U0_dbiterr_UNCONNECTED),
        .deepsleep(1'b0),
        .dina(dina),
        .dinb({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .douta(NLW_U0_douta_UNCONNECTED[7:0]),
        .doutb(doutb),
        .eccpipece(1'b0),
        .ena(1'b0),
        .enb(1'b0),
        .injectdbiterr(1'b0),
        .injectsbiterr(1'b0),
        .rdaddrecc(NLW_U0_rdaddrecc_UNCONNECTED[8:0]),
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
        .s_axi_rdaddrecc(NLW_U0_s_axi_rdaddrecc_UNCONNECTED[8:0]),
        .s_axi_rdata(NLW_U0_s_axi_rdata_UNCONNECTED[7:0]),
        .s_axi_rid(NLW_U0_s_axi_rid_UNCONNECTED[3:0]),
        .s_axi_rlast(NLW_U0_s_axi_rlast_UNCONNECTED),
        .s_axi_rready(1'b0),
        .s_axi_rresp(NLW_U0_s_axi_rresp_UNCONNECTED[1:0]),
        .s_axi_rvalid(NLW_U0_s_axi_rvalid_UNCONNECTED),
        .s_axi_sbiterr(NLW_U0_s_axi_sbiterr_UNCONNECTED),
        .s_axi_wdata({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
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
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 21120)
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
