// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2023 Advanced Micro Devices, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2023.1 (lin64) Build 3865809 Sun May  7 15:04:56 MDT 2023
// Date        : Fri Jul 10 11:40:20 2026
// Host        : metal running 64-bit Ubuntu 22.04.5 LTS
// Command     : write_verilog -force -mode funcsim
//               /home/demelo/vivado_prjs/testbench_eads/test_orec_cody/test_orec.gen/sources_1/ip/blk_mem_gen_0/blk_mem_gen_0_sim_netlist.v
// Design      : blk_mem_gen_0
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7z045ffg900-2
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "blk_mem_gen_0,blk_mem_gen_v8_4_6,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "blk_mem_gen_v8_4_6,Vivado 2023.1" *) 
(* NotValidForBitStream *)
module blk_mem_gen_0
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
  blk_mem_gen_0_blk_mem_gen_v8_4_6 U0
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
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 37696)
`pragma protect data_block
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
/RIXwVV6CE3JRQliGzIrAanfIw==
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
