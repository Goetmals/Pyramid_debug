// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2023 Advanced Micro Devices, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2023.1 (lin64) Build 3865809 Sun May  7 15:04:56 MDT 2023
// Date        : Wed Apr  9 10:45:18 2025
// Host        : metal running 64-bit Ubuntu 22.04.5 LTS
// Command     : write_verilog -force -mode funcsim
//               /home/demelo/vivado_prjs/testbench_eads/test_grad_imv/test_grad_imv.gen/sources_1/ip/dp_snml/dp_snml_sim_netlist.v
// Design      : dp_snml
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7z045ffg900-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "dp_snml,blk_mem_gen_v8_4_6,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "blk_mem_gen_v8_4_6,Vivado 2023.1" *) 
(* NotValidForBitStream *)
module dp_snml
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
  dp_snml_blk_mem_gen_v8_4_6 U0
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
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 38016)
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
