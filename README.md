# Altera-Cyclone-V-HDMI

Comparing IP-based with Code-based implementation, the deviations are 98 vs 115 ALMs.

This means, using (Altera HW IP) should provide a better result.

However, if you are using IP-based implementation method, there is a catch which speed-grade will restrict you to implement the design if it is violating.
But this might not be true to all case. In this example we are faking the tool C6 but we are using C7.

## Report of IP-based implementation

| Quartus Prime Version           | 18.1.0 Build 625 09/12/2018 SJ Standard Edition |
|---------------------------------|-------------------------------------------------|
| Revision Name                   | hdmi                                            |
| Top-level Entity Name           | hdmi_test                                       |
| Family                          | Cyclone V                                       |
| Device                          | 5CSEBA2U19C6                                    |
| Timing Models                   | Final                                           |
| Logic utilization (in ALMs)     | 98 / 9,430 ( 1 % )                              |
| Total registers                 | 93                                              |
| Total pins                      | 10 / 205 ( 5 % )                                |
| Total virtual pins              | 0                                               |
| Total block memory bits         | 0 / 1,433,600 ( 0 % )                           |
| Total DSP Blocks                | 0 / 36 ( 0 % )                                  |
| Total HSSI RX PCSs              | 0                                               |
| Total HSSI PMA RX Deserializers | 0                                               |
| Total HSSI TX PCSs              | 0                                               |
| Total HSSI PMA TX Serializers   | 0                                               |
| Total PLLs                      | 1 / 5 ( 20 % )                                  |
| Total DLLs                      | 0 / 4 ( 0 % )                                   |

Verilog based HDMI for Cyclone V or Altera series

The HDMI interface does not required any front-end IC or converter.

User can add protection to LVDS line to reduce static discharge.

As for Xilinx FPGA please find the submodule link useful.

Enjoy =]


# Some demo image:
![Alt text](images/img.jpg?raw=true "Title")
