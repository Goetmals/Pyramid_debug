// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2023 Advanced Micro Devices, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2023.1 (lin64) Build 3865809 Sun May  7 15:04:56 MDT 2023
// Date        : Tue Jun  9 14:07:47 2026
// Host        : metal running 64-bit Ubuntu 22.04.5 LTS
// Command     : write_verilog -force -mode funcsim -rename_top decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix -prefix
//               decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_ dp_grad_tarek_sim_netlist.v
// Design      : dp_grad_tarek
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7z045ffg900-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "dp_grad_tarek,blk_mem_gen_v8_4_6,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "blk_mem_gen_v8_4_6,Vivado 2023.1" *) 
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
  wire clkb;
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
  (* C_INIT_FILE = "dp_grad_tarek.mem" *) 
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
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 21424)
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
