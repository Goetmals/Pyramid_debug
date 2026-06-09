// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2023 Advanced Micro Devices, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2023.1 (lin64) Build 3865809 Sun May  7 15:04:56 MDT 2023
// Date        : Wed Apr  9 10:45:17 2025
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
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA ADDR" *) input [7:0]addra;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA DIN" *) input [7:0]dina;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTB CLK" *) (* x_interface_parameter = "XIL_INTERFACENAME BRAM_PORTB, MEM_SIZE 8192, MEM_WIDTH 32, MEM_ECC NONE, MASTER_TYPE OTHER, READ_LATENCY 1" *) input clkb;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTB ADDR" *) input [7:0]addrb;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTB DOUT" *) output [7:0]doutb;

  wire [7:0]addra;
  wire [7:0]addrb;
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
  wire [7:0]NLW_U0_rdaddrecc_UNCONNECTED;
  wire [3:0]NLW_U0_s_axi_bid_UNCONNECTED;
  wire [1:0]NLW_U0_s_axi_bresp_UNCONNECTED;
  wire [7:0]NLW_U0_s_axi_rdaddrecc_UNCONNECTED;
  wire [7:0]NLW_U0_s_axi_rdata_UNCONNECTED;
  wire [3:0]NLW_U0_s_axi_rid_UNCONNECTED;
  wire [1:0]NLW_U0_s_axi_rresp_UNCONNECTED;

  (* C_ADDRA_WIDTH = "8" *) 
  (* C_ADDRB_WIDTH = "8" *) 
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
  (* C_READ_DEPTH_A = "256" *) 
  (* C_READ_DEPTH_B = "256" *) 
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
  (* C_WRITE_DEPTH_A = "256" *) 
  (* C_WRITE_DEPTH_B = "256" *) 
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
        .rdaddrecc(NLW_U0_rdaddrecc_UNCONNECTED[7:0]),
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
        .s_axi_rdaddrecc(NLW_U0_s_axi_rdaddrecc_UNCONNECTED[7:0]),
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
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 21344)
`pragma protect data_block
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
bbQtaaO9FUxQ15krB1XlZKE4XBKijZIiREk=
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
