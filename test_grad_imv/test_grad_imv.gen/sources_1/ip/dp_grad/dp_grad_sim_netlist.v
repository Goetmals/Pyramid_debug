// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2023 Advanced Micro Devices, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2023.1 (lin64) Build 3865809 Sun May  7 15:04:56 MDT 2023
// Date        : Wed Apr  9 10:45:18 2025
// Host        : metal running 64-bit Ubuntu 22.04.5 LTS
// Command     : write_verilog -force -mode funcsim
//               /home/demelo/vivado_prjs/testbench_eads/test_grad_imv/test_grad_imv.gen/sources_1/ip/dp_grad/dp_grad_sim_netlist.v
// Design      : dp_grad
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7z045ffg900-1
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
  dp_grad_blk_mem_gen_v8_4_6 U0
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
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 27376)
`pragma protect data_block
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
IgZV0asuDwmz42sJS78FRw==
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
