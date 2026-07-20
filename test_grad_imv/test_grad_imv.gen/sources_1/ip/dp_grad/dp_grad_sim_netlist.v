// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2023 Advanced Micro Devices, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2023.1 (lin64) Build 3865809 Sun May  7 15:04:56 MDT 2023
// Date        : Fri Jul 17 10:58:15 2026
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
  dp_grad_blk_mem_gen_v8_4_6 U0
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
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 21600)
`pragma protect data_block
BGYH4MmQhIsDpYhWdS47fvhIaak974oTyEb1Cf9XzTTiMPoSwL4ZfvtUzHc7LqODz3FLdm0uddL6
uupajWXiqfEAZK2zmvBtzNhkCmwn1B+3t0pNtaWNN3Gv/aLSwIRcIbdkBd1OCme6iGtHOsdzOGIt
cRcNg7iP8wYKg0rYGSx/5P5N8NRDeLGf8ma/DLaXFItvyOfpRJ3iFv+gOeueH1UQdDrCebD/ZQ9u
RLhaqYqdKf/g3m68/wqrcPeEQrUcjf6LCJT0HCa3s1GbRwGTszWWEJVdR1R8uuaFdaEal3ghlR0l
KKMwGglStECwSuXb6vTHw+Dt2SEWWDZBuOLjGwG15vZ5f2lx6CJ1rvriS+6swCD5E1aBnyOnKOTJ
92hwwveIgETj+nWNEo5J8vYoQyJfM2VsSeNDPHC109VfJ62FLGIIdOADndHbsaaypoAktioEayC2
Cxrq4p1SVE6nBPTbF3VpJrpBOfPgaQaalslsj+qATUpAqKBHWQr4tbiSjcAF2tbbgf5eqCPETu87
Hrx9C1SD2w2ds95RuDVVQa+OGBE3FJRSoIa+1pYNGGaoMS5ifsvfXEhjubR9UDK0wGfgGo8HIybJ
VUStJrHPCyXSEYj53D5Mf3WSp10U1wKxY6b2XOU4f+GcOglZWNhiyw0yWrhEYOW+wasH9wtYz9SW
/g0CRovdPLOlIVyHqlL06fpBwvb7/rpJC1tfvZ8tGS4/vmbINciQM0ynqKiLLB4DA4yFU9tl24OS
VeAcTNIwCFtnzjh33wcP/d7m4/mhaoYfthy3QXY/mrSf3l8DwxKDvJrgE2ZrbahYTz5DggEirD4j
/RriPHVgB/TJkj/eo8OGmogT76aSlarCvlBtN9EUJMhzFZZVxz9Owm5xHWU2AEAGvFkfatuT4RSP
fNPoTJ/N2IKUStS8zpD2E3PB7dyGdvleoRadIYEzDtlHLqRZWVuaImhgo5q04pTAPHk0pv5fsmrZ
B6CdsuaFT0B2KCPgcvzl3xFNXQ7LsJxRKTHIFc9IP8p/0ZSo6yk4ZzB8AWulGrKmS/d+mmCR+WFs
acHm8j6yY5EUvpXU+XosPYvGu7TUo4MAKDRKVX5r9tS44NFXeGkrOmDufGqhUKe/7VVkjQOc3DFC
kQUvAQ6JquoO9agtS5U21guX32WP5z2/6VjQUyjU9Di/cj539HfgQE0KH5iFs4KE9ZLLtJlYUAQk
M74HEkBQLN+kZajD/qgcROzTIFrkSlLPii1zhU39ejrnOQkWajykuhdaBCXZBcRUjri6KYJ1MUfe
sJ7setoZLo8DlT2LJin/WOHUttD4BC8TaNopbM8RQeS2TCnZk8XbDppS3y1sV/uqqA5v9XHWKmPi
Vhw2xfeByCaxnHfi/7LqLDIuSbq4NiasCoF+LgiEfXyMYm6yVvHwWH+WTkLRZajCJp0gOh6NsczV
c9F7Wku70NSzw/yh0P7lKEZcpL+HSaUDwI50gnhlzFAEjwv2At0s6ulegAzsoAXHJm14QkBQIH1B
Ejjx/5Z9DgQe8uRHDRaW9yI2ybY4SSrRRyRFrYOJdS7eI5qMS+nKET1lR7u8ufzNeolO3a4TdjIA
uuJ9Uhyimus9K9GuSnGVYUmYbHnCnqFiG0YxaLXkTZNEkZeJUwS2XT08SHBtVjwKcEaOwUVCt+HM
Tm7w9coJ6SXrpdxAccFRKLal+gmJha54Yhaqu+gEUIMX2gXJQ3Rg/YMyuMFCQHhU868Y3bQFJwUB
ammi+MDYZ75GM6qXwkeIM8BygvMMW1gbrdDD7mIQ9WgVyD7zh6t0L6bu6H5ZR9j1InCcy/JNLGfv
qDml9vzQHJ6C5l0zau9aV7agM8qrr08D1IrwaE9cdXhAkS4ju2asj2cVxpJ2ysE9qcPgye2kpR7h
/wr7C25h7Y/ZDZmsj37jsnI3rx4y1P8fiLuN8sdRIh/ajYZreaHMY4d4E35Q0ci/2g7+MazZZ7ps
MmKjXzaifVW+H2rxb1mS3Sqr/s0qeX34hFIGKSDWwG2a7aYH401kO1iUALoaAECW75cJQjbjB1hn
hOE7OE0csIXQHOuNnKVfV/zi9vmfQpIW/120/rjEgcTuIz1eoQ+rD+pCWhVv/IMVF5E1/sXld+7x
fsxC32b35x4Ge3zc8ybPdxRKryG+8L9qb6buOCrKCtH4CSoUAm4g4gNgoPojed65VKIwmmCc6OU7
ahVCCQQ6XoTZOF/Y6MP+qYrduYykvR+I6TccMWxMHSEe2NaFkyFnVZ3/DAodPUWXKm92Pq6r5k8X
+BoT+OgSfCjkxqWRSbVx4+hqRcxo4qzV5mWdRrOOo90Q7but4EfpjxBelYVCI282Iw2xnlt14IHm
47CTdfBAqzZJgJqECmPt5kt5JuKfXHly0wJc2e64Swe49FE5ud5eUk80EuQoMDHIbvbl66/1rsdn
CtOV3jEMBjxpQg4exslKclMpL5Cp0o17/WqKVkKknlqiHWH2AjlocNGBweMyDGOtvoBqvFqyAxKJ
FksRKD9VJsI7yng8uNwBA5zL3wZQwaQE7eOEHC4Tto8OqKN3f7u6WkYz9zNG/cgmVIGWrgPx3UBq
C+mGC1WbwcdsTETzlji+SlLoyqOn+dCYV+0laRpTgWXjkk+MNo1cCGR4/OzdYJ2sDXf9MVjH3fjm
oboc9TRTijsIHfPCo0y+FKwlCKl9ep5GhvdCxIzLIGaFNB+84oHdq/j4n2WQLlblgvIQYrK2u/sv
dyyO3Q73kZyCGt2pvvXYje7gAEJizE/xIWoBjMi9tgMnmQ43PzE/oRQF5Nz+Nq/MI5oZpuee4kjY
ULe8USMmMMPxhEtLLY+7F9hqxNAAUXvgM03/lwPQIepZMH6ycZDce0mRtRRcYUvOqC3WnbGcteOI
2Nrf+yfD+rJ0u3vscGBfedOEpVhna2mR8zoxpJRK+txApIm6PI1ahOPQ1Dw4OW8iyYCRzpmENgZi
lV9W8540IFKKmczeIVaBxJRfAiAeU4WJzMibaprwMXe4x+tzm5doBvlcRmlSZXqgexdqpNVATY9g
ppgG0EUiwYcEcYfII32ylTjmCGccz+0AZ70TCJdPQihU4O9LS4HF+FSfjmb+1FBFOXj9vL4GrrGA
VzpdA1v8UdpMBjZb4nNWsjKkffN7QyhUT99Vt3wlpy2TKysRM+AOgg3P5rm2ZzpE78wn9jquoMIC
eaLIBGCpyUKqWOgSVo8QL4JNLU/6rphVUxTJsRZ1NyrGwn6tV1l7WH1i35AomNhbtuziBKiQGmdK
j2Yuw9N66O5aP0J7BbsUApRSnp7rwnLYJ220WlhqLxuOaDhljyMl2omYMp/oQs5Ij3aMn6AXfs8H
o/MVX0RaqDFBcn+HIYTUDYRuSFKwwWrH9gt1LNqkHdZtM/Z9es9Eq8iajNCRRepG/ZipJD3EXOg8
3RnzImgG9SEPTpHQL4SirNwQplpcdFLylPTnl8FQ/B5E0i4bo+mPAKh0NHEEKtVVkHhU8d+6fKJF
9C6D7nEdiG3eCaBHGzIzlQBmC7re9cULAP8urzso03TyEKTe+LvrTS7tf+mpbCMF1k81y0uVt7HB
3Q1dCvR19f55XCn0EGUhmzeCO73usrY/BJVoWCPNP/aBw+A90V1XYtyQk35heNBo1CaDfsMj25pG
nZ6ADqur3XuKX9vdKMGHR63UZPoaAmsXoT+BwLn6TEsPyzUZzFyeH+5wLoyMIEPBjBRGjpTgO1wj
Ik7Dy+v5iLixEFl+Z0HmvaJ3W4NSekG6tV/F/symGHKCUoj7MCAF5ohmVoOAEDonVuhMFIEwVZOt
f5cWMv0jVmv6bi78QW7+1zojN8j4j1eoOcj3hLeAPYN+LEMLIx1XyplPGtCHuSjkJSLOpSv2qEkz
o/AJf2+bm12jrPKIJGc4JFgp5jemWtRDZUA9L0F9m607sk5BuZBY4VDeFcPiqyLiGet72mXTzg13
R4KcNTEVlB+v50M4TTof1GC9D4ljqPVUv9QFzEwDqdvjt3AeFhrWkHXev7Dtt03Ei1j7XE7fwnTt
ncVMUXTxAb8lAshzrC1smZ5Jm5bjYHYHr5bOLutemOqQbXFW9la9LETwtNPC6jqcmoTjLIG9UBrd
oHjzf+uF+rE+CUS1+KUglKBNbZh2eqKCx9eyvctrNIVkGZ56LH0ntetRDrH/L9a1LYySuK9ypekZ
YgVrZ5SXTXXuZgvSsKaGIpPKXH5LJwERJcX7c8b3zN56kD+k6xVic3P1UZTvJlBDndFSn6jR+xe+
EyT1FtJiX77gA78inpjzWMqSBabvNzwPRB/6NdyLb13XGgW01Vwospy/1RezSAbGl3xa7s+j+NfO
PFTI22HDkGlilcF0f1dCbhpdRBNQElWyXayyyQFqgpi2d/SeLjAcbQ4u0I4Fd1XC3DMpsUysoatn
BwggJrY1dVNL6Eb9LldoL0ooimwVCPCQwwV7Dom3KbbcdhdasLP52k1YPQR+OJm0DboDIeW3ZAz1
Qtjht5XaZHnQlTXEM4MgLHcq+s33leIFQOiratzWu6kLCGoIAo3W3aw/uVd6cnRUrbRyl5bwafZx
c2j0Xgg3cTBV+TkF7fmrD43UlPXvIQ4cM0m5+TaqMLbe//81fLP4uJfT7KSDcFd7InI2UkzUs45S
Ks0TbSeCxs5H3YqB86x51vPf07qT8hCThfW+ieRtVMsvHcSmv2vJfTOq3ygVCu3+zbrBrrvjpQ/k
3XYXWGUgPzsN3jwKlE/3IHlx6834dDGEy3OCyF/J2/6JszX940VRZYffG8K8JIsBAfp62rkxEhYe
mHhX7AKxuq1iytKqoVVEICwTt/5PycXAsuSLC491EtJ8sRZOiVWFpSsxXkcBe5YG9j4OXW0lWCqJ
ifim8peT06xtVdxGL2xbn578Yl2BlVzlmd1nuEzi/vXd/T2RY4SHtOWXe5HseW9YSczwVLR5bd7X
VuETXx166GQAZsu9+jn4DZuJj5pocDpkKAMzzmCnSRR38iZeJgwk6cauQXhlRgwp5iE6Mn3E/+Ae
oLQ6Qjn6ipO5mx49tzSsXHnlSaBglDH+wK8MW/bWIBxJl0RtW4+quQ8dX2tv31l0MCMTeq7pcDlp
kbtaJgbEt3OTQexQxDfjWOTZ7c2fEKL0eHSy/EW2htRVfEKOEbu52JAqWN6jUxZo+1pFOJZ4pnEs
mRNcTgB2e9LE2WBGMNJYNJqAy7dohl7M2PbQwFhiIqUN+If90TWf/CjMtJ4PTxUwT/nBYty5l6cw
xxBty391RPEcEEb6D+4wFUQw68nAMgVDWMoqKYMXHgwUxZbhEb1WH3a9EZ1YqprfKNKhW3wLV8ox
LxiTc0BHTYLrNBmrPq/UyHz91pHhZYPNeUUiJG5O2PwErDT/gXSl31dRAbUxFkjVVv6KfeSquVHV
/KgQVwegUBh0gtUec4bRBRDlDzBwfkxIh8CwxEm2hOKiVzeOs2Mtp5QCfFHiIOO6nZYOFl1z/r4C
0JJjmQTdjDm8llxtBTefUk2e4OSPYBEodyokQ5D+WQ+pAnyXfan18Z60jo+RZAm/pTsLwPYm1u7V
s1R62LxOqRdn3HyQkF30rVhKBk+hezDkjTANDagqo1qMGif7GIwwTgrMh/ABZMU/7NPHaoGpBMxR
PT5+CyW6AbgmS9egtdKFUexpAS3pCIqjzvW7wCrv38Qd9ER7f0qvf7NPQsPCdOfCB0ZF93RkGMTh
Vtu56imnSrrX4a9sfQ0Gw1OTJQjlv2hTJw0TmMBdJNLnOrH1Lp2y7QY1H5vVHwR4rHOvUFfR2BYB
AlXiK2XqxB1vXf3egnbju32JJVjxKTseGNkXqxMAj+mvLIGG/JiR6Ayuvs+ddGmI1AJehl75YDGX
V7zY6eYq1tNUB2FCi9+/H76VgktWwp67QvgQQHVSB2Wzto+zA8wMLgIWdVNrBC8ET8oRqmBFzr0n
gJuagISE9bntvfJIUjZbTACRRY0HcI47Ka2tKSpALLmzRJy6W8TK9RfuW0dES9Z4mCm+toSx1poF
Drx7h3Xij5dFDBXQknEVF7ub7+lgFDhDniToNWmYKzsbqOE00WJdY22+b6OVQgKcuCDjLeE4WM0n
eE9ZIMHJNn9EUy6FO9YqzUrFheigD3PUDRfkPMiobQZjLjoW6RU283zud6ZaihvOQdHn1GA8QdIp
UTVJ6QbXw2zKve5wiFFpJb6PlxJQ0Phw/Hhzy9aXtx6Q7hDd1ivxd9nM4stPqFdVuIpb05isUnm2
Dc+l79Ovn18CE20MY27Ya4osBqqF6oNUNyPbaW6buHbISWLqqSDZnwkRGbTA9QOx5seuClULPvi8
G9z7ydhiNjaIkj/plicaFafHKdwMWHgss0ffxrVC+ee7h5z/WTQtMxEpowCc+wKqwCoiY/dX8xVJ
XCrJX/BYntoW+kjijKPfQfrMXK2piZNx4jUKs1z8HfWTZ44aqd+o/X9wSsq1QsUvrezXwt0UM+Qs
AQjYmA06WwEHPmDOCGR1R5qd7tmwtvtJw/NcEgE7dZ3g2B0hQ4eGqWg1fWv4fKc3yQ3O4ija5d+b
cFQ5JSHs5Mh3ile2++JtpSz8Gi5s2bKDLGLyKJfsKGwFxgWbBiHalCiHsd8GGrX8ZF/LteHefZc4
uSIacRICn0zQ80ZS1e5ev4CqDrw5v+Prc4U+ZAWwcOh0qMh7FIElmijJzP2ceSVxvdhnk5Og6krW
YtVVH8jRiz/ItwNC0dRLc8vDRdNI4bfiA/fFk7FBZ00hRd7f282Ws3ijGivorpM9Vo8PPvZ6wjS6
CdLtZ7rhNAa9QcV0QvICHOWA/BL7Ejp9YFBpsv83XRg+N5IBF1yKLR9dizt/SllYUHKa1E0gPj6v
02Zg34z30yQr5p+r0sHOJ9cRlV4YEZnKv8CZQoAkq6G+L4ifBP/eo+uxkxaNYx9RFmnv0WiT/NEY
rXOeXiJ+Qgi/6+qfB7D+vz2+8HAG0inrxZHTalYLJVq6lEX1SOGxcgfDjg3BgKHgSys/6svzPSED
5qJWEWvAYaH9NkpmEhoYCTR62Yc6ZUf+A9GXnK1NlK/uaAww/We7WMaYFyzrZtI+T+vqneZltPzy
pN/4VPf8kQul/V3LpDBlJ9vCIK6Rmkos8s52NTJHK2ZOIsf1bThrCYY5UuWjt3VLj6w5BCBwI5j9
JpAYuofBhnJ8iYI0XhyVSgjwIR68UR4r8zxC/xGWeWNkhbLfNWaOh58Oj+VBb3W/Q6S/T86KWWeB
KlmC5tM6tfm2N3wpOcYCgCDUVyfZxW9XxZDKcsMW4nhnwXAg3goqA18pFd9gJWvcXtRwSR21Gd3H
7RSC+KqU1OJjXrN1TxZa0qZgRBQ//Q/q3njy//9IBdAp4BkNgQ6PIqJkSohLKWDa1887K7f+cWRB
ZQVaZUvSID9gbcfAvAu3oOBWDiDL9nZa/9rxw3LBs9hA0RQns/dCRdAQN4MyoNxaVj8Dbk7/kqSy
8CK6b7NudfndXNN0pMsfEKbpUKt4dei7aCAvfydBLt39wskiVLJl+Hk3vxnTGNnZpGepOMf7Yrhn
njZgmO5lABpZ5yuNEOPHyWDBaRz3+Ia08rd+VkwRO+39iuxbwmvTB8qk+m2Le6myBH0kDAZQkZsw
usHyC1BIP8cBYTRrgZmLUdIV0vcRghB/U+LX2C7rGSBjx05Qv6ZeUKE1i8spZqtgtqEEKHcfDwix
B2kgMtdM605OK1IrJtTPWyLL/0zQQO8kwQ3ijvHczh+9enp5O+5YFcMCZKe0YkyTF6yqX1UZcZEn
Yx9ICy/BTZCKWffayAG4w0BppZW8VMTjf2F1mjtHwai0cS0xcUrpTI9owqnk4+jLZdetwAfx0xYC
dv9LhlAnDs5KeVQfCcg8j+BmxLVoSfmaGIml3z04GemDQY5TiGsMjQ70WmcApSfUtmkYTFKifp0e
a98kPNrylBL68Se+ctoop0eR0X7/8VMALjDAeLa3XgmjGxod+xCDCx+QloMQPXpp/dgtM8aXJpZJ
YnRqjaqZ8+ACwW4ZJCZ2lZMPlw9uzpzkSudsesS0GpydK1WemAsqJ2iBT76wZ/Xe1MtGhI/CfYM+
lTPaxbbcIFjJ8a433VF8BGpLw8dhlv0/s0oXficF8DPJK/0HNjLUisWKxzQmPhayGGxL7aqJzOyw
4d5jDbgCUVt4YYxSSUFX4ERSlRlUGJxSvjLr1rDYpQCOMSuUzcXDvXLiv0i2A2REhNibP5wVuCR+
PpiC2L6AYAVFw/UBCgEhW+JNNyI8CB7igP5AHmcFuL2v1nLaX4/gUtU5y25le6pfy5F/3PdiY7/O
tyojFbsziHwwp4rM+zpK8VVTLJ2oIH6rRkCv/Fh15BSGBSHfMo8aQlKRETmAfdAx+iDj+fP5TqMq
hbXOH0vphOUTcbSqZD5IvA0Z7X+Or+t6Ce8qvziPMaSNGU3RV2Eb9y2jPzUm3UTrilDLYTKObDgk
r0STxeH1voKZggaefytEa8p1rXdnJ2bKhPmHAlTeqz+Wr6W3+Vwcu5nziahCHfi5ddFKDI4QiUEP
L5v+geyaA8V/E1aeohiyn2OpszansLjZ7jTinHcn3rZrU7OgAvL//eydZ3Vwuew7puS7PW+G5WsU
pd/stf4CRjLx8LEDIzS5kfxSCCnj69YZSbfQoLLY3w3494QKzH8bfb9VtZ81qtDgWfCpmJ7NE2Us
NgzUcw8m0a8NyArov8YflZxGL4gzoOhUQA81lawItVHzMaPw8nRd53xVWE7tpws7BXYKM9pWWBuL
QQiKNk6Ti1XwiRS2PwvO9+kFEVG6Ho9b24EhZEhwhsEW7DqzXhNCayKsn5QfiBb4m+svfbKJ5nsa
+9KtfzE51xd4y8k1sTJyv4e37EfKV2injZhzoUgGEWqXGkGGRTc2qo767gEkp2QMh+dUkBs0PDHh
Tg1metzfNjfpxtpILZZqKvFrluItnf+p9qwe8xT1oEG7we66wlWC0qOb1XtrrS2N6rHn4k3J0cdy
j88bCuGvMXPA5gxsjXcuOSpGUSRWaM/cIBCq4G9PDj5LHYZyEhOh9oIcuiLME4s7PCK0ODosSYzU
ijSuJhpU7/wYgzq9KaGcPfpnedzwUQSgeNT3k9juY/VmQv8OeUk0/hZTmmDpozDeBd7iPJqOHgl0
NrUrnwkXy14kCOvu8RxiT90bmlABKylHwv0cCPEcdhgWGXzJO6hI8spvlOvYMPl5tHD4af9Ly1B0
KUEWw7tY++n79PqRcMKGGSkxFIN0vO54KF9lSg4ngsOxQpGX5pfTyFWNhoCLOB/OQb1kghfkvRTO
zrzsRS75vuM5PIRVqEhHx0hON7/XjJvGgIrXyMUSoeHeV6Z7gk+X4TU/iB+Q4B/x0Rphcf/YFfKb
ySevi9rVwndr0hkJmGk+p0L8LJL3Dw37yNCzHPN8L0xPztaJ3ThIRRoFkd76V70uaaJXq9YwmUMH
/wjugVuMt41RNMzM2Fgmm71gIlB8S91n+Act7vkzr94n39VxNd4juHNHFw6+gvvlC0yvn6sulU2M
HJdZn877qV4u4XvaG9u7mUreessPrLN3/TorX8K+xxdMXd9hU9OeI07iSBWMOfonJzZq9ASRUHCD
QJIlMOMGywDf+7eSqLgOK1MIZ2k1CU5oGmOBDOh2LgRw+dwhTHaZdh7XIDaVOty/6DbXPF42qkyN
+MmDc/rVK8VcPHMsRTPieg8FQI/XcLujl7bQZutRCd7rvb5Qdg2cnMVzWs8NZjJ+CKWkPoA2kUZf
Sx9DucI9veIA7CseWACx7lS1pnq6ZH+7uz0HGmEn9d6xFZKO4F/rM4uJnwbHEZ2szAdbO6sU82jV
Zl9JsmscKxUXsKGiRFOm/aysTzqaQTeEAuwDJDYLPGY4ajvPtmwO2J0lpfPBRO7tBZpruXbsE53y
9c3LU3VE0XuzUuCjwGCfpVQXI+uwTzz46AfOWxf1xeSe0vKMxYnNjxtYc9Qm4ozY5wb4b5u5fdI0
z+kW6iiTMwREGx20285Y5Lj5v/DtDt0V2KYHVpMfncvAFPFecDFX/mK+KnYDxvMQn0M2FtFrJTy+
uN7ib4or7DMRgVrivKebHZSsS3poZPzUP6EGiseUW4GOqA/2TK6MlN8PQb8EEr7dFm8yvZf7seEn
yofsCgc/GF1zGT4jXKOmZvCCtEiLuEdfGQtij1rb/sUK1MaTjOv0V8MgXreD7HrY+WPxI6qZsWWc
xdO58mrfLb0zeBVwvwB7SScbl0JjQn7nqpINh30R4THtSHXn/a67q6gcfQ9pZxH9brwz/GUqlmvx
j+WQCkABpiIV53Bcz0q0o2FRXsS0eroKob115JcMwCbQME8l6GNaPKhWDiFj8xqYSV80reWISYOa
sK/t6O+4htuGd2SbEtsu0yUsw7P0f01kEf4KyyQwasE5E5oYSFauUI1dhNcQ1wIpniGDlwZVVmtm
3SR05Z7aITjx2LJJre6zA3LAJSDb7gtLUvCm8oUihMDoh/3Fl9+ZjFmZk5cufjOYlnZsN1DO9//N
dycNEBP7qRLQq3Hj1Z/hd0aJeVSGFnvPDadEd51nBiC1EvN4oCOQ/ybs/EV7hx6m/VUaq4unD/PG
JAu6MAcBIqzUWVt7/iVmJzaySHyskF/zuSxB7qtOZC/q2eesLD1aKZ0SmoX/ShSLmcqXFO9KezLR
g7BddQ0SHed6Yw5QxSprGP9RzgGlKjZQtBT1Yo7NfFzFuyzXCfpW9BeYO+4Km7xvQZ1MY83z40+l
aDfU3r80nPPedktI0TcDWYwbE4FQEFEPHwuxDkoA8gwUpFkDw9ZXZIs+E8Lo79h0TuxY8OI2dKNs
T/3bshKiZsqO4t7Dc2Vyj9ohcrq5E0Cw/C13KpCzUCvLoV6Rnb6TIKnWji24+8C8afcPGLutgD4W
IseBUChOcBfJFh+h8M8YjotfW+CyXGv2gkaLa7G0bowoGjnYcm6g0HyKg9C1Jdyq7fM1xEtuNVBB
v82e5MeGKLbcBIRKzdTdwFq+sxnX9M/7XUGJ6J69keBALMee+Rm6f1XPM77spZ0G1RexCHlpD+Cu
OApWd4W4zRDeUPvGEB9eyuMbUvGdm+Am8Dzq+13o+Ej/9p+aN8SvlIspNyyZWUo18lHcWEq4QRIA
qHHwnLKQv+WgocTn+gOXIKEUK/TrlQD4+DjInUEsFXgzbHxRLfnR8UZs2rT7KMmFFb5KJgzXjTGi
4Ps+d8mKKu607qr18gpyg9AnT+12lTPF/i5oafO6fU5nRxZiUlZ1nb3gK/OGpjAGSuEuixqYsw1C
FPJ85GxyxM4JO0ViV3EGpDJn9kg88zR0nObZ0hJqbwI3NXpujUIR75jbuMpzEraOlgqBYwlQ8goM
eonI+nr/lWGeHzRSIQwCeGa0sC8bUQUY+uDfTguJ/uB5As5Rh69HiRyUw+AauADPTwDGQ41v6EcC
s35h9oUD11YAvjiBcKnt/TVMhaORf9GQ+Ge5HcgjhZKtKPTK/HKNdsAMbKiycdixmeJ0TJRu4x7l
qljJqLLKkoRVF+fsQ5r3FkzNkuZEIEMMBgD4kXNSIMEDzQb8BaBTLv5jH/y3v+9Rj2A7s01C9uqu
Po9akvr8Duu+VGRVeaQNHZ0YyI5THXpK6P/dWHFcOeNmL9MJdSxRhHVD6ng7snyvPlc03e5Rz0Kc
rEm5CK3coNCGl+7uPM+p4WcUxDjv+9JT5gMTPw74l+Vsr/3b9QD0MaqHIxN82LqeUjX+xbRf/f9y
q/PtkxwE/uSJzZc8dP8aNVQgXPd4RKPBBXpF4Hjql6FQQLFq83Lc+NhTBKu/ArvxHuyhZI2/RMwM
MtTcsbAIJMm9QgYaf85URvIKj7b/d+If/om83QdGJwGDXzRoS+73F4IDZkgYTsLoXA7Yrc0i6u9k
TIVhHU7b0oZlwputcBLfYtnWSrSTGjoWDR1tGZrApSRGMI6ivRALdW4MY8jvWuN9WPwHX0AdM288
r28zrr/zLSnpHfRBhSxF4MP5HVWJIsN+NW9lTbj1CEEP4KpIFMx7QqK+EZv0BVR6CtdDr1sb9ZRu
e3i+L6QUeaFwIWjlYIZy65a1EWYVjACoUMRVg5Lj8FwmgCQyVYztJSbvgRgGrhfyxLWbncRVN1Xy
oCqeETdRhgZ8dPm3X+D2fM1mKoBnMPwMz+Pb9lS8N9/QRxZfMKu/I0MwWBmmYNvV1vdEPe1GHLKe
XE9kAmftJa2yoNHTwWm9IfoecGlmdPhZ/cNB15S+NvA2M2VIsqd3hTL662nMUpinwIITSYeO2DAB
nz+4O7UDUdNAjMkJgowxNCSZOrXlrs+pGmgRRQUlgErDBIivRc1Mib0y/h6rorNVnoyTF6MWwnCp
l/Lr73EVL88miXvDPvxZ3MJHA754atsedh4wxJYet8LocWBCoNQwPbOkjYYAFHUMjEki4KNXMinB
atUzFSMUXPPt0rec2ZGgg7LRknbBfJql4iQ42b/yd3e+ITvRP55VB3i8KXRiulqew2jAny1anYS+
oeuXm7AUc6QKhT7kohqiNe1XcYyyZ/4NtoNjnDwB0nDbBoa9LjUWWnG+UczOCV48RqP5mGm0CJKe
6Rwj1S+BQyHLUyLzzc02OOy3p7kGRRxofuif4DYWrc5qT3OpP3xi/w6KaF4v9MDySCz6qmSuyPLU
ZA5D/BZfqcYv2uP9eJC+aN0/HmrCHGDJRd4HlxQpFGBOdrD4wSKxwLfPbtjTxKREJpxcp953FyHW
yilL+rb2sSxGxa0AJZaXXdB/w8p/O+PlrAaMBiSVXoa/tdJJVOoHXkICtLLi9XKR0fqii3Te00V3
mUIIf50ARj2Yaw8q+RH03ctyfcVwTmzRQ4bv8mJQk6XV3oqPsfRXfzdZz9+RSuRqnCG5U1NV4nyQ
YgvhXtMXtdKWzEyQyB3gryngdeFOV4EEXf06ZJPwZ+Ba6SpZH0/p/FkZBGMDWsJtlA7t9xKPsTNC
kncQvzgfabbY/lcxu0NTNM9DysJ+lHsMkGxeazJ2KZX+IqElULb6DCPnk1/iceyFoS4PYvOZUmdg
277L+w2h6N5D+p1XsKgsv1nZm+ms1J5gIynctFdXX4xnV/cSwW2ZbUPzyvDHfruQ7YbPARc3iCR8
Bk3/BJdTdMtI5VNB1qsXu9zC27AUXuZ/v2jOdbYe9WJnaP+wVONDvmCWORKfM3XkYUCwqUCw4HJH
JPnDjM16vcME1c8cNnpqw3aeBVPXfV+Kpv3HSzRmWm3v+P48hAIfMThoRSlmSILU5DrO8hJYuc6Y
Gvw4Yljo0p3bjefoIIL+88F7K/7BhiWXy9JtnQHytsm6NnsrjzprpksTzEe5XWMMcU1dXO5Rx0aV
YVTcAjLNbN1odevNFf6VnYBJUoyFQ6y4TTkF2yT3dBNl1Ic9kxN8fejUBKODCruYGYpQeoQOA8/Z
prh1Pfk7SwRxBxBztrOkGIlEwHOuiXUqpz+0dZYC2v/+ziqTEtzAYrKv1LMeBMycVkDrKgRD9h/P
vER3rYCN6gtKXvrtHDNmiHco5QpiL3DPlblCaxC7Iv2Fe8xNzWdWYv+LBxDKF9IzhCwp8hWDU3lv
ZR73qd5SU89z8F5C28t2IDL2DkZWh5jAvtOIDf55DNfgVLfSjiWRVRc0UyJV8YCZqhJ2lbuTIg7l
eOEDYC/8IVP3L3OE/inAS94OnDsJbe7P+vZRwBCjMM/Gylw3WW+HsMK1QVbahiP3hApiwjiQG4/t
agIqQdZoOxoXjqfaHBiqarOW1UKxqxbtcaKekr+qFkcaJCYmEbro2CzNFr0AkNrQpAOPTUdsORPQ
F00v80i/QZqjy+iDYOKBgO+s4iQlbtrxPdU/rS2KI6LY5f2QU2kgqb073NX9D+UovRSirg7Pn05C
lMYHjGCRD2xyc6Wek/oJ9quBZ/rltdg/yrHcQn0Tx5E1O93KLWffJdd5BQse6YIIzVMS8pLEOpAv
Z59mrvNo8OUROtsDPI8PajdO3kx/F7SMcvNCSAjoDL0KauFTEUxayHrcnJtwoIpUVYuTjpVjvdsp
PxTAvu3KHsdv91JELa8Co8JSsg4EN9SFLEq0pMvobiYEBLGsfej3zxboBP1PxmvZ09hfJignz+ub
fe7vtpB2CuUaOt8Ry5Wju+0xyp/S+537YVFuRu8iQ135dYtpBFF+/6Oc529CtSpvhhc+KJIe5XP5
UVeweT3zc/WDGdsPO9D+a3K+Dtmkr6O+0DdRYXiJ5XpEv/V889JE9r7/ObdUr/kGmg1BeG7emL8P
nKE2m7yFEMmcwYHFjLUxXzgaOvBS6Hlm0mhNchRLeN/aRTrCyev05+we4hUIK2ccOrVumG3O7Ap1
m9hrsv2ZFCMiF41xxkQNUEnbAbOF13x8NMA2wjeUX3XrUYx2H4jTZrP0T0LlA0ai/wupIqqOix5n
8MA3KmudGDV74fljD4D6f2OecL/VJqEFjzA0cXKB/iFgUraH4sBpqVcXap7HM232yX4ZIQ43G/SO
Gidb/7jPb0eoiZtFFog3oHMrK3B98JeRnMnfbE2fWl4GHr/dw8HsrJuqrnHz5tZZbZ+7bqrxghPv
XjaZbgDMtV2UL0uRDehwPiRD49UtCOGmtxi3aHZR1ol+h12gNY010XVRzJoir3V2TW29c99tyQSz
FJ38eHC/39mpQxbGUTlm+WdeLj8YcgsFyJt4SqpzNoA3NVGUktZ/6HzRgJP5XvJtxIXkRuTnIyuG
vr13MgzeKXT7sOVIjRpXJWHK9owM4tKnS1n8CwY87LmRjFuGsvCjS90Duq9AaUSAVratIAh+Iatg
2aPuUgJ0xZyFcgeKCFRJ/G09E8bk8N3f2pbItxuqQjb0Tts0u9lGKkp6u6CsFQ/kwaW8hXjkJCXJ
Z08XNSf7btEgRXH91zsWM3IQq3InBJLSFcKbmQUChBFzQJsSyh3iJzz/Nh4djW7bz3/XPP9nwq69
1WM/rLguF3Usi4ZfnXdM7qVQ5FciQz84q4hpcTnt7GXzBXN9TLTjQFybkbGDbVgzF6Z2mLfizStc
w5Edoe4Biyj5P/QZ389A+/z1+QQoByoW+2lUpXP+nfwn/15XAD69d/tn9BlqFyDcq6fqj9wXxRTU
5OzJQc5QOTVzHFrUvpn2SWK3b2c1HzVxmmp+rwSynZl4R/ehlJo9q6QE1cwXlOvRoL7Wr7owbCZw
9FKa/6PYyQKy90vqRV98YDPW8BEIR2VWEMnikLaotYLpt6DtQy76ytK++FgYPz0tUNwg8RRXdn7X
ZS0PdBJWi1dHa2KH1OQ/A/16SN0UUxeVSRz7FYYEc7PlMeQ8LCunvANe9u2Dx5JUj8HeCDNbya1O
OAQQ/1wCXWpY3VuxqCw+kCQo2bTyH3Q3h7Sg0k/ulOMkZNInNRcNxu0dsAK3hwlAet5w9L7/iuap
+Zda7NeWo7dnGxMd56z1erPe26MI3NxQ7BBmSHbMu+Nt8YnWAex9DNyNMVAo6BUpEr9ckRZVfrix
JDePX+kFCEpOd9DIUO6vKuYsxMUYWnFVciDPhWQH4qWxOC8cA8UUtcNOhMrTICTwZf8cIl8ReHAE
GTjzAolH6HPnfAl2Si/ni60XiYpbAwru4FLDoWr5GVr3LLiNoL34RbzD23/Bft8b5BYCN832o1aM
CNbmuVVnGEEVaj6sjAX9zE90nTSHLroEsepWEOwFWAX24DwiLXxyD6nrnIefs7jKWV5I1h6fDqwc
EHHcpEomq9TOjOQe9NaEGKDYL7zSCdPfk5OTawO+CeFNBoe5M+392Ee7Czo2xrhQnE4ZYzVPCa8q
t/O9kGxKZdvOsr7tX+OBqT3NBZbtbasPEMXJSfxjwp+YpaH9Qq4cQ/qt190ynUBNWFu3vRCy1mUa
LJfaPiika+hsb7boP9FkGEpHSqD+BdLEmI0gvyjNktzrKeDtLbj4i0+4lTPEH1fA2PiM9wbx/j1X
rMroZVRIKhuxBxcs6o5Deu/f6OQlykWywZFVtp86Aya2Mo75m70dmpNGL5HscFvLNjhm2qjwH37T
TJnm2KQEfOIPdKWo+UiaYBZNSY9eRmHHgIT1rN48hBRnqfXl3th8YiQbkxPiKKZ42M80/wD492uv
bra9but+RoQhWRZWfYbBM9w8kFO6D9kDbfjMdbkQ2xbu1wSJrvTAvQpqxHuz/THiYywv4BYcuY/6
nk2W8fH7+Ci33PoS6BXVhQAyh7RaqydVZpRbDtDUVwfKz3BbbKcOf4A61nc6lQAayp7JGGTK7yTO
9xVzHBF/CwNrEs09mM/Sf+E+PCNwl7JI09Yihadx+VSsmShusg+YPU4D+CJvD0AQ2RAPz1h35Me4
5poxHWyk1/2T+lxruoRysoxpOGP/JO0GDvJ7Jhd8OuD1n1q7hgZQMotczQUNp1iebrnWiqu45Bhf
xkRQtixCQlzi5Ma2UjwkwgQnWqcND/tJdFe+jDwV3ZQgRlXsE5LaYnKxiwmvNAc0gkwtDKb6GVR8
IaA3htjphKFClnk/APw0sE5AsGHJiITtIxWKulyA7njNUCgfNHow+iQMTE6BfLECki5Wjhbhv5pT
r1a6/pNZjQrmdPcxlAmmJN9uPpCWhO20aT2/tpW/3qJeFpLpEjTdGmB50L6uMllsNkFnYU+928F1
7ulVDq2zITVKG7S8UruHlwuH9/yJNX3Hv+tAVIwTjHVi5CavyHETQ/dUSBoocnz/kUIEw6Tl93rX
CAnhJsGm89QxMxXLAHXbn9Bd02P4jjLMg7FfJ4XStwkAXCX3MwBBuSsoqCUXH3T8rCp5SBnzO7GM
vlbvgXcLTCoUkK7LDaoAg8k19WMWduupbNAlTBUkXGObrfa2rZWy/8dGVcs3DLa6GS6C8q+cwk5w
/Lx5Ynp8KUavh4nvzx+pSQFcdX2kmRczFeB8yMp+x6NPTZUx9rQ5Ybbvfk0e8jH0bF0pOPFxCThF
dyiAvkm3XFPluoLuX1cv419LaRD/E125PvgwQwKYttiiU/+yxE7aZGA+6GsUL1kDRfgVV6ro46e9
NStAUrMcqwKkGfF4bzMHK17/jny8NunbDJNI53NbrAQ4u0BBzARTYBWrz2onNLBR9DpF6n7obIz5
PBIqcQKFQeSTKEIMrrJL1bDBYkBC41Kk5ULm64qn9csJHIy9z4Jh3Zn/JkDLRKlE6LZifqIrBAi4
amKa35vZTRJd8iAoi1BzmaH3qheKu1P5JKA7F4UILRxjaFCicvK5aFhz2rI7by42lQHnBdfMNE0L
N6oRfKZzO8XdRd+HrK6ZgrNp634dQ3eOvgR3erf+DjfhJk5tLSb6wRfdWDnxCY6juBG+6+908Kfd
+eRFHGQjTSekkLUu48qmMDuAEUMGvyRk02knCoeCb7Xp92I0cMX6CNCTJx7FPQoGXGUvHrT7pN8D
Ekw4w60IzkMfhUdr6uIDaxABBXQ3OuwrEkP7EmkOsfL9+0+q92uU3LXmncn35+85coOWWkEy+Dq0
c7pCfwxlLlbw+t5BAPfLrHOn+gLHeD/qRR1GisC5Dw6eTfu8EJxE4FWr+uFW5oc6R9YKQMeVUzWX
v9Rpz5MF7ltgAB89lHfkF3g23kJCAOXc/fOKy6KOEhKWeifRJtGoHjFIJokDvAORc8x22kN9/Ss/
twUQd9a/qHtv23o2WBkfGZVpIYn1jhiPVorvsuf9YcruOz7a+jC/5GQe9LD5QAIGd/dzrOZbJ3dQ
CGfd1CJwUI/YBOcjvpgCsyuCZhJ9pJtCWjLpeevuyARj9LaYLkq1xNSbswF/CJR2XKhOaE4uvohx
XVYiL1zSTK01k5w6w56P7aDl+G+yfmO8klphcE5kYT8ekFLrVYt+iDLQBDuDU6VIUxxuJFX6XPfv
FW+8r4X5Cvc9pR0MgenEeVYeuYOX3M2pGRbOmrGR2XsmCQmiy4DXn3/+OR9Eo0sy4wPyXUOZM3we
IFo4r47kgkGl+4ge2lh9kio0KS+BF8XZodA7QLK2AjOTTaxjqa6gd47VTWZm5N2GjMwbChWqmTDu
/wyKYfZxqaOS9byViJ3sjiRhTq4Hil0yiKHupHBQQh55rXQWcmObBM18fOCrVjoJCNxvMMLLHDRW
1kWF1xkXQg7SB2+AABgWUZ662ntDc/AhkjE9HNJ1waUD1DiaTxcsmqrjQa7stKed85AIruEpLIAt
alkk9fOlnlfdZpmrT0n/Ycybw312gYFrcQwFPLQQPOWNGQht4DmN5/tWnrIguOSHQQo1JcvgHAeY
fqfq66fCH0DqmGL465AYa1EvOU/1zQVmjViDtz8DoyphtjHuiJKwyifI6oFavm0zV+17UQIUAeTy
9GDbTmNJ3vEU0SH4CV50y3PVi0vOMPqOdMcGxiLdN5D6jXipeb7PinVPRqn+2F3WjwNS1c9c2PBw
dF+TfO16BbV0cqkfzG2jb1G+6VqmNwhqyWsvTVPuixGmBNQMZDH/BVgljTzq1TFs3y/PDRuFFaZE
AO4VhVn0Kvb8HMplb2sCOLs09I6XIa3KNvNxegCih82P5roK08y7I11jFVwWGkHwlDuIV79cLpi9
QO1eY4oFMQ1L92SudH0CAUxumiqmOt6OXJ9jHA3nSG2TUcVA/oy5njdzvijvZ0AN7mky3ou9bZg9
rh9gYT7ulNd9Q+Re5jhzoThKcbAGsmSzsRR1QHtbd6EILY7nburxUxkNT5v0+fm0H9kUh3bsT7nw
eZx70L1aWvZV6RomjO9E0Yd9MgMdsVLqosKiDF3yGWIpT7ClLM0CVLQXXifW8rs2eY1pv+Wf8wHV
jpOzLtT5KCbWkkIG33S+HkrlXKz+q/vcsxyUljb71LhtXna4LA0EfQkvzBNVGcGMcWPyfbPPi5qt
lu4MxXQ4dzKCm+RKxIzVrTFUVTBLwuwHTD0SlCE/UeWhQudCa8hoBt1bA3Tfj/4t+YxakwZnDocs
g9APeuYtnjqL+rBsyQ0nhnvfoE2eUFW3KInRl9ckKMH/EgRMjqWvEylX3yjXeTFEOBCQsXAns52K
b7rdUEntw09f6BE7wW6UuTRRoMbZHIQwXjiW1G21xunWt2vEouP3l0OMOwwmvA02IkNaC5Sc65Bz
PRaj9YUUntVJRO1D2bSZJ5tChxiM8Vkz27AJoL7eKjraKzmXXl98cidmlwmx6EaCN+LCQDOAq2rd
upTwagtP9b+QW1xi0W+3TpeJo6HRntSNQv0HrR0ogybfIMcCtD9EMYl0oBpLdIkTucGHhmXPmuYe
0Do5/bmYi6cT5wMQ+DXo9nfaMHWHAjWLlakRSK+3Lmk+ODbhHFOAs/bCI22N8YvKZDCpnFEDzsNu
mWXYBtvflRh5ELi/qOPSpPoRLD8pTwioXrbUeVoeOXDgNO/c8isnm0TsRo0jBIf7fPScfo2mCU3V
Iwme2dfsw7ZCubjy7SOx7RTrghf7XDXw/nU/HYHEoQ2kXXE3JtjM2g754xiHVlMheMBFBGSaGkmM
79iAh47VHySw5PNY+QM8GjVXo1J/9UX+hg7dgdP+9LHTig4sn3MAElv5ZjlFTJjxN9IRCOpKNkFD
j77IGj7w8rm05ov+fSguZGjz4kX4kA8rzW6h2L4llT4TcUJ9ge7feaudCvh5PBs4r8X8VfWh6fSx
zrUzhU4ILR2EE+DCU30nU1fMka5Xrn3e6qx87UocIO3xxxhR5jfDFK7rsLLR8A5Z7Ou27Eq1nX1b
jp9SAsvGVwPt0uKykHi8B6EHuQE/ix/3UgY2c5+5KgSsklHgUgBlwmmxB68Jsn6sr/ncqASq4dPH
yJN5BS5mJABfF9js4s+/poDg2Sewncsi7W/25s8Wa+1VVu7WE+3WuWFsY56T4y+JOWwGqP1Azrd3
sO78l0XDgxH56Wwj6B572XVA/4oeB9aVKMx3hr8WH1JwGXjvv0sA9pG8XyWMU/HZMs7RW1YdXkXz
Ilg8wBd4O2Z4rNaW1oJt5E9fjtXsyJSjqIVAQ3M3JxiXPkmR8NsSGyyoWVT2x2GT6ANUFXEL1jJm
HANc4JiVJvOca3CYAB1rNgnX8dhZ6YwArCJmZ7GCcWkdW5hM3YW0y9xAPtHROtyNLJDHvI+VZqOB
TYgvfQI7Zja2/0TibEnO2NT7yuR9Y123kgvLvbeOFwzqaxASS/LBnXvQf1I0dHS+IcgOsnAjRfoG
GSNx2GYr5WIE4uGjFRwr3UnlEapyHULCmceQdKNPCe0NgPArOPN31wEwT3fBWbzB3oHQEqC/dfW0
T+RHfLRF3YD8Me+HvKd6iMthf5Zx3c50lKmkj6/mlXz8cPk7EE2535egVrKX92D21LUNoJGOrPt7
p4V62i7gdbjZHXb7k+KW++cIBHG8FoX4S0+XoM2wFdjdZ00zMxbSZ8RI4kswxOzqmuMb/eULGXRe
40Vn7RbKSD8vGTbOcQp7PKDJpcRsCxKoRAxOVC02fACVRQRdIkUgek7FP3TPyL1GRhPN2RTFjXUY
ShT0ifjTQoHQlLrluBZdKiJ+0ZqS97697ZWW6S7eZOAKwLl9OkyY4fN8U/IaFBk2NcMJ1bs0PEOF
Cl+S1lq6BgNOtVUIHRlRRJfg3usQ33ZVZ18Gi70MlUNglsKcddFXjfyYbq+5EGDEB82mUNJs4iEV
ZjqhR0+agiOgfAk+OSP71ruea6rjkKE2Q1mpD4q5kd2fBlTG/fNgNlDORXVfNeocssZ6sVHbhJM9
LBiGrDhWYc+lqU8h9P1tv5OEeBExbXWAfqmKvtHmFFgjnQWDqyE4NK5SNj6HUiPBgQrZp5/IrIXG
/cqgUbvTggQWBIBCuMM7PWVdSSPyjEJM4a6/sO9QYcRo1X330iuyWK0/9nQDEBLUOpE7Rvo9Ytb9
EOovo9frGFZE+PA10BzeSNXbGW0OnyJvxbeXkNctMMyH3JGdJ7Uqzw6IU2ahyOGaJ0w6+zz7b1CJ
a0xgbSu7N3lFuZAQVO4/4SzDvnfT7Z9vKbOm2GDhsJNKYJJZnibaIOapqOf/N5lwXFsbPdc3H1AW
Ci3EBdlEgk1sloUDGPaiAxm4/h5ZUP3uXG8AHqq/pr9pb+PlkLorDYQ9aXii0zFwTULAfBvfsjzw
NfH52c0bgtBxSnSisNnfkyxEn0xeGrAeLmJ9hGA7dF179ErL/0epShHgBKwQP/+WnXLY+H6zuZye
O5yTLdRhBPtBMO6iI6mLzxDYYsv74XYwARJNdhyFrJ7DsniVXXP3qIwy3M2cT2CLVwwTbkUjRF0p
JWFE+8AMXIama0GZLUeJ/+QishdFma6sZQe8Uzo6LZSg88T0dn1PrhyDCkzX9khwBk5n0i/cY4g7
jfgBrPeVLl1id+sEC+6DgEtfxkXfhRAG0eCebaMCa2rX9A4WY6dy1WMRcBpoDPwec2baQ9/0hiIW
EJ19suNnTdQA6rdTWm1/2MppavIX/Pym4VxOgiAuYzPVvpp1owefV1PHWFkD1e8FeNCiOX6L7KWc
jAXndRIowf8yfc5c8kXukYru8tXF423lMignwrUN6dIo1UPHJ7GCkzcpbIm0P8QYcclPrUaGbUpa
NIt7yyUz4t3nfMPfxKOGjXwUOcSHsUfnf5KR49oMRK2k4Z6HHxiWGqmUqZepyXgc6cTaoBW+ZmJd
WlQ6ghyfEvEvV/TLpbT3mpsoM8lCa+W450Wqz2YYj2ZcYjIF96YcCJLrRKk5FlQeet1+MFJpO3tE
htY5bGcyzRHofAnmgdaH+sw2aHmSMGiWFeMBO/nU1Xceimxddu9x2sNEqZF/OS764JOX+yFQ/y6B
5kbtsv50HmQ6YNqCjI6S+FUJXbqC79Nv/BHCbR0y4VNubyFSls57fuBV43w7yi6HHZFUp8ZH03oX
RNRH6m+He7e2KXECC1yEFlOdGpnUheSTDWy9eXM8i9MAtVXrNEtHX3TCZcXePO36MT7Uu+R4kfQQ
PxJV+4CTQ91kxtCTjAlqw0JhqQkXgnh/8qe4ZNtVBETJMe3lpJQfBgd50KJUPruXg4PgTYXHO5SK
HDpABbbGEq9F3xBGm1FNw8a0eCiJeWH/vmcp0ZO76mQPfCniUvGeXCu2zkHlRrC/xx7JNx2TKDaI
TtRtkn96B/fagdbtWe+KZtGP2PirzppptnTHZgE02OpdWn2nkNpktkwXDQf+A53rjg05NSJu/C8W
yRIL0NHlPIKi58PFL3H3G5uize7eeIBm5Z5lSw524SMrJUCgIuH5Ubl4LarJTScUc05IuQLfn7jL
uulhWo2n6N4J+9S1y2qLhDaaKATaJWHceWvLBy0MX3wseltaYBokbmHFpxridn8p70IyCb0OXDrC
5SFSSyW68crrO/FVd3UxxZJOiOjgFikn+aYlx/fPPufctMPzzRCtIkRdq4MWbVuVh+RYHkJDa9IR
OjXm30PVRRnxQyKpLeYn5K0/+ikGDPWD8N0KHx4vEbrLjfF/5jl3lAFb8MQpyHWXGazqrV6NnLqT
JLy652G2A7EUvuFcLFfqCSgF+50qXaH23JxRAdyyra5/iuI/hpI7CTqm84Hwbj0wYR53V4RtWob7
Y3tRSQX3FjvYYtGavkaw/GubfB+ahv1I375UGp15E+gvIuradTXk7JBV7e0WVy/2eih4IPDyk6wO
4e8P48P5TfFBlQIRXqmxQ/aq8y7ZcbDijBU/1l18eMJnvIf8NiP4COiBSOvnUPzrS9q9SUyPByE7
cyESN8noSTtAxPeIFpNI0DgY9cdZQ8inF9zL2US4djJgyh9N7EEdAdNge1KQ+m74ngTJSl0+LCU7
czFFsBd8asfUZrL4Yi6v53tkFDe09PJeMnYn8fbrrKD3CzGZq9mSH0N+zS3N7OTAO+wdc2tvpkmP
eMvI2YQJzRwOBNQPQPciEe1mQ/yyAzYwkRiNNx13+ubrAjIf+JvlPwvckpY4Gl39Y0P2kfItgLka
5RTN9DdER4aPRwM79+QnPcxTkXVFxOHpodE3PiG1OE8VYfDVUU3Z92B0TcRix7svdv20VB4HM8Gz
DOtH6YH7eVhmdvbhIYl6D/rabWx/M7+bYMGQtonQ5NQaJhKHispL+Ql6iZAmBwJua9kHvGA2d/6V
2ocMQAX3RWX3AxW8oz16lpMDh/J21UM3mXMCzaqOupBGpCRTmZn/uEoqY1hYcc6APtk/iUZAXVon
udbrx7CZlwAGxqa7uIl14DUsmjQLezrSx2NiZZMcur25iU8T0pk8krZ7QsgNRnTWqCFMnvPmd5Ce
6DrugzT4a7CyGlrz79E3cdlYIyDeqbxgaUXCrWlOWU6qn75yZ8MRLw3bhRWg4yogFmBl7cJgQXOa
NQ36HG4aizKMh32K1oKimGlYLK6/Sfpr2slAom8vQm0xOGXgKKDLIP9ElQ1YCU2JHVrNmQEA7+2X
4iHpqWq9QzBO7XFeT8S9vocgr1FgnHxnqyYfzgQK0unB5kMF8MrIYPVbd+gxS48ZFXEzEdV4WHku
sC1TwrlWnOuCO5+2RKezx4QVaVXgMBslunjZaeVTwasaAG9otxBP9TVOSDoppF1fDiUMRzbk72d4
H3P87JMX2miodNZeNuxcoSwuEFJRDfqb6RJbt6+HKGcYhwdthf32w38ekUNpGzOPCh6xk16Be100
0QjeWPVI8j3MeP+hczJBmM6g/Ct7krv513E+3sUcEMXprHNeqSV4xAybgLyB0KkEgMPyIwuhuh78
vdGywN6u8FMZd1YwNk8LlLIbdaAJs9k1yad3C0+IvTFkNvtRMJplGpFpnsul2T48msRJUbuqHRYQ
8mSn2LXoyLoF8MZazz6Piwvo363nSgsfRRYDduDYcIzbiQQREvi0YuVw9vtwMtNQe4Iwi/DZq62V
f9s9iWODVfmhI96pn08S08UHNRbNJieKy93fxLpPoJ38b6xi+9tf3M8JIGnu+rdlXavkT3/iAfKt
Odn0bCZa3zbpD+xUQh26GlTgCHlwJnyZenzNWhZqZwnzIs1TtvpY5gEfBL1VJIMOXmwv7Bze9GWo
/pSezgg5V4fEC29mg6L/bEcjt2Kxq3SjPc/1yE8n6n2u5jj2vr9Q/7E2Cfruj/HcGWJ5W+Fp9Abn
GXxM4TNWDqEYng8owhvmfabds72fiCksaTxyJNhCMl02ScuKP10IVsoSBYD5Iik7oi12j1l/VmIC
3/RlVbHqoiXu4L4gTcdKYx0BEt3vmPhRfS/o3qptJ1wvQz+bKWz4MzVZI6XQOXzgUu5RFMNFxdPy
W4fEPLTzoXoRHUSvPBT+/neTiLm+8eJAo7Ln07tLYKfLHrGh+5WgwlXMg9LRDoJfHv3t0pHMZ0mZ
c6+xBze4leYhcavOTETVpHqJhShnrsxu1oz29VJnx+zM5d9zd2pZltD+RmpDv2U6qF5qo/T31HYL
xp4++TqI2Jsgq8WfMKYegO+gemivHcl6T/kX07zExZ2oOw4rQcZx1zLHZJBWutTxdpQYG3XcNwy6
swBnAUStaZ6SIoZ8BHXmKhatafbcQiK2tcTKz3JU5yspOOq+oHVfOByrjmtqlCar6pIfojlwqY09
ed3X08+bHhxEvCdlfsoUvmAuMzQvgGuKWxBG7IebBR6C3RxE5RfunfzRCE06nWULTsojJlFwUJJU
A0MzUPc0e1DXqdOcatRtO9CmqrggUHbuUAaIABgBe9Ya2jIjEcGhzBCTzMMCsDVunNOYlNSyyW6j
SS7u/MwmI5SbTXbjJpxSlly1sKZliJcQ+VTuKNaXGLxYzfb2gA3So1ufU3McyyRV766nE2hPGjoM
ETH3xltyrGP39Tyd8hwdxrrFR1Gd7cdAx5s/pji3sKaYfApM97/8ImtrAcNJtsQAziaOsMxL7xnL
OscYyznzAe5GGFcaGqv44tEhHOC/YKNd49jI2LnLfI9mwPu02mscciwN8i/mn1820mFeFM/xl9su
1Srk59uwiDNSrdjmWQPt6Lr8uEOvwdJI+IampJb+hugdNJiUWiTIyAOwecjpXxep9qRUKWPWdDd+
sh2960j0vRxdp25tD3xGrdDZvkWDrU+8sMA7lBfziOb3hl1cdDcwDRMDe8/NM5kAJ4C+Pd8ivF1h
DLAuQ3xEF8clk0V/YOC7CAgLi+K4aRFzxr910UOi4FtwJARk3cWRMVSjLKVxeQRNAoQQstor0npJ
ht3IZ60XX4NOKEmMzG8/IyMQi+sthuAwIQuSDoKa0Z5mAFZQSzlGmVKdg4ydZakFkVT5ZVo3QZG0
1B7jy8tx6ZJ3DECM+CH50HjD5djYhTg3kcUhwOjb/QVjyURqIJ01kHugme75H623lfSwokWOm+Fk
nUb1VxH2v2jqzGo3zYpy3ghiPfNti8TZhT/er0qJiWNabxRTTGjo/dCJUwhoi4QZ/YFNExwu3Yro
7jhoV+qrpPLAY5PRcdR9Mxqsp/ztJB8te+0ZfbKlodvqr8ZeGXWHvPaMYBpo2YmuuA+TDcrOJhUI
kJi9OrDAju9Z3CtyddEUD5wdm2aRG3SV3/yQ5D82P1fUYhR7skkHjJleykLyxX3GD5uxYhDfiOms
fHXVmBRKgLL7XqEWUt+IktaUr4NFnrZqJx6l3JGuDm6I25JWqZICB5WlLXyMWK94IrQtdVvvEjvN
STrG62dzE6DhXiVUpKoOk9xrQrh6E+11fej6kKdAyO7OLkMwnWbDoXI2DVdV10eJLBId1DfkFB80
I1+XL0IJIRYHwozjwagDx1QPNhFQG2rmyq6iB6QaIvLgg+2DpASdQI/N+Fc2cJGIpYKAm5MqUSr6
Sk7hDICj2d1cAlyQiuBkibERuiXbORIoCayv1CM8SDZvxuLSwYXmwz+LkmXufFMluRwoJPCTbS+S
cveJytCqfUCZFRWo0l1V28DyUZfB7KEczwbmJzFY+W5ABeAGUWno66I3CuVyeHtU7hnocF1kXPOY
OTUSmT5oLWS1D20hPLE6odaZMfhMvkmTgZgZ8SzswSGEBhZrfDCBQwTRotGlZfbMkOZBceU5O9Ch
Ptyp/4diVuO2RdUjs/3KjyJY8GaEpM14ATRG3TEatf5rMf2aRDU2d4nTYc8zpouS6K0De06z7UHs
9i6bjUIJgNGZhm4m+xexFoMTiTtHMAKhrKYmjl/btDiZZFNo9vjSDirWDKH/79VQX/WpIvne7wTO
PTGoowmD5NFX0/O0VddCqPxj8bNKjQZYzHr//yJ9oaQOkc6bt6zzDAbRkrm7KHRVV4vyBamNd1WR
0Wc9NlWO/UeEaU3yP2DMxEmkWQyCBftu88vSK6Ny9RgSfgTidDmohyWsEjoJIYmYeh5i6hqr6JbM
xa1RY07y+vhe/N0QzLHKYS1NuDkX8i/7k5/QlY8NSDIyVm9hJERWK+1PuyNnYERK7kBpldmBX1OS
HbtuwKJMvAUfScosrj3t47k/An/h9a3YTN0ob9XU2MyYicRSkdVe7XNRjM+8NKGyG2Y1kdmt9M1l
zKilOeTaDIC5hOkmiroVIbyuvNuERd3NWzS6C8pOK1OLv4I1XOFF5J6GF/w5dCpijb7mrpNsccps
fLjb8eXtBne+kIfTJUYtlGNbTdXcEMKmdbGqIUMOVMyTeJAhxqEoTLyfM2Cs38HC1ApXMrK4a1xK
uThU9reL27M4KDupnqFhLwBQ/5BAkOxU9oKA3DZFdNHLmMIvIofJ9P9PcXFsHAMuwRukNgko6IOp
PUSTOafoDEAQDvmFUe8jnBmUo91Km1kjiTxzpZVmifjzYxT0qoPrl411VY/TR9UU4IUcmzF5WlE2
8Xtc+GkWLkeE1kOuTnyACf49DQNWP0Q4Wh9KEVxtIX7qZbnsPpz5MCaQziMT2ZVs8DDw5/IXMhJR
2VqvocHfiAgEQ2FkA+xdNR5KKe07KUGTWMkk9mtAKBPQjK+zKsOhHbx388WjTBIItvhi5QbPvzgj
643Cr6Nl6nIfKjjGdqwtx6LA6HXMcbCdncDqoCTKlmHAWEtkNndnv/mQo6Mzx2uADGn8guaSRcj5
nywed1Wg5ZlAyOPQ4vkfMLSNsDhhbqhwPZBcdQ++Y65LsFhkeQ4ZMMXwaUSDkjG01/hsvzwCNXil
GB9msSVOeSDuwu37GsIbTLrbNUBHtVqtVzkyNzMvmeR7DCWUFIEqcK7aL1vY35wzY5Sc7UZB74Ur
uYq5987gucB6jUdKMZTv0gwz2zuOKq41JSFLNnRiP/ZM2Wy9+G2ENuxrt9r+CxYcBAClRrQp+McW
QhjS/s4LovuF+oKCXRjLfgdVbywXXe6tXsCKL+/boblGNVzTw9cClSpH7wIQsp7QRB2bseadbbGQ
Cj57EykFUOmSCGFQHp0FWOEECYyTVKJHYQXjXeDkUrLjbyHyP5UaFZSyaW64ynH9cWShgz31rUb6
39nrwdMmtNpe6VV4pTQ6oVQQp+aUgx+XBqDn/7Zry/YRJfKn4Mhqu40LHZcVgCV0U9TNHB8xaVdT
lDI/gEcG2C5/GN4mJXSVlyUtTOvDI+HYDBwBo9mi6Y7LnT+QtL/G3sTFidDqtVk+kYpVuYvoQ0Zh
APgbF49glGlE3qw8+mrt0iEx7KkN/egWPVgEmqu+1hEBVJ3/M91YcXjV/m3l8TBsp9P1obyAbIo6
lmFn0XAYDFwbMndYs67Khh5T7aXf5ANiTmWs3oBbte/d1wh34bAcTmJbTdnb9nYTQIIgqAd9+TS6
yQYZmkM8/QSQ8b1HOCgLm9VZ06/812fBvAYQ1/WqEdWlOd2bSwJdqGC83zzldqxwTBaZm6dOKhAq
68P3rnH36dte1usWPalp8OeHe+URUEkP3nbaDIfn33RjUSDF5PlayiGSb4qT8KJvFU6EfwXK/6ei
yZy5WAoa99Ax5BSgU5cenWgSDV+UE7tgn3O8RI1n/o1Jf/uQ3UqfB+j30zwMcogDMHbbeKqRT/tj
/ypiYGO/VzpLZJeD3moeCEIBPSRqjT5iaU3gybF4pXt3Hoy9muUjtVNbtExlmVceol/g8DGl2eUi
evAJxDq5Y9HKBI4WE1WEa34JApHQWI/K5R/Gcm9QHpHzFF429PDYpw4C1eOxuZd16B62dOvmyCW7
hPHWqllDYZJx8awUNEW5UOP04zegUUhDFn6F3KFxzDBUfTGfWg4LeKuYfKkCD7Q0KI9U04TVGBwH
1WnPurn/SDRLeRYjQnyAk/5DVtrTJqwKzMV6Zctjj711XEQtxzdzs0/wX8IYKFAXZrOMwbN7cPHa
SweHH8ZcTk5q0GoFMoxLmia+AA3zLRzGomqGd7GbqOLz75at0ZxG+I7GFlb7/r/+T/tXm5H9s9Id
jjge9cdc2d2ykFBzKwmd22viQj6glt1UWEyl59FGB3cbcvAdHn5V0TqB3tnDjyu48PSYr7pAolxx
vFxZVmIqUrj/iFA4SIxNZ2jeEqM8YIBmd0RTkO3Wr6/ZulGscchijU6mlrl7xfg2vOdrr60VFUnf
PMgclpP4QvIHczeWJGFKi+SW0CoAvqNX11QszKEuSnRhBjd03c8rVjATHHMD65aIVHFfQ89TLwGm
6KxQTKt/i9U18nIFBsfZdZQ+TwOUOLKu2mvAUno+/L0t2MkrV3SzS2mzXPhQfVjzDWCB/mXQQLoE
MYCXORYxgsDq1mriCk3z0plTYBXsmUkyiE5RqkWUvDRp1xgQJQgnVEzBRwQFwe2LBoqHANDnDQx2
cM3SgWsGSh/eCrFfKZOXAjRzpwPO/2xo4v/LgBoahKzAidubsR3bfoRNHbXDPy0B0LTFVs2VgYaP
umL5+ZhS9r3kTWMo0fcxdVPkzgYtdvCzkPTirCnhcSbouIeyQs4DmKIlei3g/HpxUcHDRjKcPSf5
BF8Dsqrs69Vso6q3o3EH+GcQ8Pb7/TdphFxack53beSstDRILJlM8zFyGvsDhKGwxH1FsBXxnMYf
7Ktn6ZURH1VQSOnyFueHe1s7LLfJ5MprdtvAs8ZEYD1bcWQvfryceRrL545AByL+fij9bYKw
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
