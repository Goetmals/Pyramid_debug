// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2023 Advanced Micro Devices, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2023.1 (lin64) Build 3865809 Sun May  7 15:04:56 MDT 2023
// Date        : Fri Jul 17 10:58:14 2026
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
    enb,
    addrb,
    doutb);
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA CLK" *) (* x_interface_parameter = "XIL_INTERFACENAME BRAM_PORTA, MEM_SIZE 8192, MEM_WIDTH 32, MEM_ECC NONE, MASTER_TYPE OTHER, READ_LATENCY 1" *) input clka;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA WE" *) input [0:0]wea;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA ADDR" *) input [8:0]addra;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA DIN" *) input [7:0]dina;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTB CLK" *) (* x_interface_parameter = "XIL_INTERFACENAME BRAM_PORTB, MEM_SIZE 8192, MEM_WIDTH 32, MEM_ECC NONE, MASTER_TYPE OTHER, READ_LATENCY 1" *) input clkb;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTB EN" *) input enb;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTB ADDR" *) input [8:0]addrb;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTB DOUT" *) output [7:0]doutb;

  wire [8:0]addra;
  wire [8:0]addrb;
  wire clka;
  wire clkb;
  wire [7:0]dina;
  wire [7:0]doutb;
  wire enb;
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
  (* C_COMMON_CLK = "0" *) 
  (* C_COUNT_18K_BRAM = "1" *) 
  (* C_COUNT_36K_BRAM = "0" *) 
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
  (* C_EST_POWER_SUMMARY = "Estimated Power for IP     :     2.68455 mW" *) 
  (* C_FAMILY = "zynq" *) 
  (* C_HAS_AXI_ID = "0" *) 
  (* C_HAS_ENA = "0" *) 
  (* C_HAS_ENB = "1" *) 
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
  (* C_WRITE_MODE_B = "WRITE_FIRST" *) 
  (* C_WRITE_WIDTH_A = "8" *) 
  (* C_WRITE_WIDTH_B = "8" *) 
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
        .dinb({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .douta(NLW_U0_douta_UNCONNECTED[7:0]),
        .doutb(doutb),
        .eccpipece(1'b0),
        .ena(1'b0),
        .enb(enb),
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
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 21680)
`pragma protect data_block
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
s9sQfNj+k3wxas3Fv74x16nZvl8=
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
