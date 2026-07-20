// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2023 Advanced Micro Devices, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2023.1 (lin64) Build 3865809 Sun May  7 15:04:56 MDT 2023
// Date        : Thu Jul  2 13:26:30 2026
// Host        : metal running 64-bit Ubuntu 22.04.5 LTS
// Command     : write_verilog -force -mode funcsim -rename_top blk_mem_gen_0 -prefix
//               blk_mem_gen_0_ blk_mem_gen_0_sim_netlist.v
// Design      : blk_mem_gen_0
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7z045ffg900-1
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
  blk_mem_gen_0_blk_mem_gen_v8_4_6 U0
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
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 20800)
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
