// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2023 Advanced Micro Devices, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2023.1 (lin64) Build 3865809 Sun May  7 15:04:56 MDT 2023
// Date        : Fri Jul 10 11:40:19 2026
// Host        : metal running 64-bit Ubuntu 22.04.5 LTS
// Command     : write_verilog -force -mode funcsim -rename_top decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix -prefix
//               decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_ blk_mem_gen_0_sim_netlist.v
// Design      : blk_mem_gen_0
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7z045ffg900-2
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
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA ADDR" *) input [10:0]addra;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA DIN" *) input [21:0]dina;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTB CLK" *) (* x_interface_parameter = "XIL_INTERFACENAME BRAM_PORTB, MEM_SIZE 8192, MEM_WIDTH 32, MEM_ECC NONE, MASTER_TYPE OTHER, READ_LATENCY 1" *) input clkb;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTB ADDR" *) input [10:0]addrb;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTB DOUT" *) output [21:0]doutb;

  wire [10:0]addra;
  wire [10:0]addrb;
  wire clka;
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
  (* C_COMMON_CLK = "1" *) 
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
  (* C_EST_POWER_SUMMARY = "Estimated Power for IP     :     7.362 mW" *) 
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
  (* C_INIT_FILE = "blk_mem_gen_0.mem" *) 
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
  (* C_WRITE_DEPTH_A = "2048" *) 
  (* C_WRITE_DEPTH_B = "2048" *) 
  (* C_WRITE_MODE_A = "NO_CHANGE" *) 
  (* C_WRITE_MODE_B = "READ_FIRST" *) 
  (* C_WRITE_WIDTH_A = "22" *) 
  (* C_WRITE_WIDTH_B = "22" *) 
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
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 37824)
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
