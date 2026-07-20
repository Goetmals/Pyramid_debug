// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2023 Advanced Micro Devices, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2023.1 (lin64) Build 3865809 Sun May  7 15:04:56 MDT 2023
// Date        : Fri Jul 10 11:42:59 2026
// Host        : metal running 64-bit Ubuntu 22.04.5 LTS
// Command     : write_verilog -force -mode funcsim
//               /home/demelo/vivado_prjs/testbench_eads/test_orec_cody/test_orec.gen/sources_1/ip/dp_grad/dp_grad_sim_netlist.v
// Design      : dp_grad
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7z045ffg900-2
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "dp_grad,blk_mem_gen_v8_4_6,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "blk_mem_gen_v8_4_6,Vivado 2023.1" *) 
(* NotValidForBitStream *)
module dp_grad
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
  dp_grad_blk_mem_gen_v8_4_6 U0
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
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 27072)
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
