## ssd_dynamic_display.xdc file for the Cmod S7-25 Rev. B
## 12 MHz System Clock
set_property -dict { PACKAGE_PIN M9 IOSTANDARD LVCMOS33 } [get_ports { clk }]; #IO_L13P_T2_MRCC_14 Sch=gclk
#create_clock -add -name sys_clk_pin -period 83.33 -waveform {0 41.66} [get_ports { clk }];
## Dedicated Digital I/O on the PIO Headers
set_property -dict { PACKAGE_PIN L1 IOSTANDARD LVCMOS33 } [get_ports { F[6] }]; #IO_L18N_T2_34 Sch=pio[01]
set_property -dict { PACKAGE_PIN M4 IOSTANDARD LVCMOS33 } [get_ports { F[5] }]; #IO_L19P_T3_34 Sch=pio[02]
set_property -dict { PACKAGE_PIN M3 IOSTANDARD LVCMOS33 } [get_ports { F[4] }]; #IO_L19N_T3_VREF_34 Sch=pio[03]
set_property -dict { PACKAGE_PIN N2 IOSTANDARD LVCMOS33 } [get_ports { F[3] }]; #IO_L20P_T3_34 Sch=pio[04]
set_property -dict { PACKAGE_PIN M2 IOSTANDARD LVCMOS33 } [get_ports { F[2] }]; #IO_L20N_T3_34 Sch=pio[05]
set_property -dict { PACKAGE_PIN P3 IOSTANDARD LVCMOS33 } [get_ports { F[1] }]; #IO_L21P_T3_DQS_34 Sch=pio[06]
set_property -dict { PACKAGE_PIN N3 IOSTANDARD LVCMOS33 } [get_ports { F[0] }]; #IO_L21N_T3_DQS_34 Sch=pio[07]
#set_property -dict { PACKAGE_PIN P14 IOSTANDARD LVCMOS33 } [get_ports { X[3] }]; #IO_L11P_T1_SRCC_14 Sch=pio[16]
#set_property -dict { PACKAGE_PIN P15 IOSTANDARD LVCMOS33 } [get_ports { X[2] }]; #IO_L11N_T1_SRCC_14 Sch=pio[17]
#set_property -dict { PACKAGE_PIN N13 IOSTANDARD LVCMOS33 } [get_ports { X[1] }]; #IO_L8N_T1_D12_14 Sch=pio[18]
#set_property -dict { PACKAGE_PIN N15 IOSTANDARD LVCMOS33 } [get_ports { X[0] }]; #IO_L10N_T1_D15_14 Sch=pio[19]
set_property -dict { PACKAGE_PIN B3 IOSTANDARD LVCMOS33 } [get_ports { AN[0] }]; #IO_L3N_T0_DQS_34 Sch=pio[45]
set_property -dict { PACKAGE_PIN B4 IOSTANDARD LVCMOS33 } [get_ports { AN[1] }]; #IO_L3P_T0_DQS_34 Sch=pio[46]
set_property -dict { PACKAGE_PIN A3 IOSTANDARD LVCMOS33 } [get_ports { AN[2] }]; #IO_L1N_T0_34 Sch=pio[47]
set_property -dict { PACKAGE_PIN A4 IOSTANDARD LVCMOS33 } [get_ports { AN[3] }]; #IO_L1P_T0_34 Sch=pio[48]
set_property BITSTREAM.GENERAL.COMPRESS TRUE [current_design]
set_property BITSTREAM.CONFIG.CONFIGRATE 33 [current_design]
set_property CONFIG_MODE SPIx4 [current_design]