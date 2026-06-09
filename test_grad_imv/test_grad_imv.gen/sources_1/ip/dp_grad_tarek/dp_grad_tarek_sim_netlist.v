// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2023 Advanced Micro Devices, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2023.1 (lin64) Build 3865809 Sun May  7 15:04:56 MDT 2023
// Date        : Tue Jun  9 14:07:48 2026
// Host        : metal running 64-bit Ubuntu 22.04.5 LTS
// Command     : write_verilog -force -mode funcsim
//               /home/demelo/vivado_prjs/testbench_eads/test_grad_imv/test_grad_imv.gen/sources_1/ip/dp_grad_tarek/dp_grad_tarek_sim_netlist.v
// Design      : dp_grad_tarek
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7z045ffg900-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "dp_grad_tarek,blk_mem_gen_v8_4_6,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "blk_mem_gen_v8_4_6,Vivado 2023.1" *) 
(* NotValidForBitStream *)
module dp_grad_tarek
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
  dp_grad_tarek_blk_mem_gen_v8_4_6 U0
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
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 21392)
`pragma protect data_block
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
YPiijYeKnhV6qIcRIEcJw4M=
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
