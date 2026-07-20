// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2023 Advanced Micro Devices, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2023.1 (lin64) Build 3865809 Sun May  7 15:04:56 MDT 2023
// Date        : Fri Jul 10 11:42:59 2026
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
  (* C_COMMON_CLK = "1" *) 
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
  (* C_EST_POWER_SUMMARY = "Estimated Power for IP     :     4.9537 mW" *) 
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
  (* C_WRITE_MODE_B = "READ_FIRST" *) 
  (* C_WRITE_WIDTH_A = "16" *) 
  (* C_WRITE_WIDTH_B = "16" *) 
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
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 27168)
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
