# Bleskomat PCB

In order to make Bleskomat easy to reproduce in a consisten way and compress most of the cable complexity we are building this PCB. This PCB aims to connects all the component that are required for Bleskomat between them and with the microcontroler ESP32.

## Requirements
- [kiCad](https://kicad-pcb.org/)

## Resources to learn
- [An Intro to KiCad](https://www.youtube.com/watch?v=vaCVh2SAZY4&list=PL3bNyZYHcRSUhUXUt51W6nKvxx2ORvUQB)
  - It uses an older version of KiCad but still good
- [Tutorials](https://kicad-pcb.org/help/tutorials/)
- [Similar project](https://github.com/RuiSantosdotme/ESP32-Weather-Shield-PCB)


## Resources footprints

- [Kicad footprints](https://kicad.github.io/footprints/)
## List of components

| Component                      | Description / Notes                                                           |
|--------------------------------|-------------------------------------------------------------------------------|
| e-paper display connector      | 8 pins in the order of the e-paper screen pinout                              | https://www.digikey.com/en/products/detail/jst-sales-america-inc/B8B-XH-A-LF-SN/1651049
| Button connector               | 2 pins                                                                        |
| 10K ohm                        | A resistor for button circuit                                                 |
| Coin acceptor connector        | 4 pins we use form coin acceptor (power, gnd, coina and inhibit)              |
| NV9/10 bill acceptor connector | 16 pins of the NV9/10 bill acceptor                                           |
| Step down converter            |                                                                               |
| USB adapter                    |                                                                               |
| 12V socket                     | https://kicad.github.io/footprints/Connector_BarrelJack                       |
| SDcard connector               |                                                                               |
| LED                            | Led that is on when the board is powered                                      |
| ESP32                          | WiFi+Bluetooth+Bluetooth LE MCU Module 2.4GHz to 2.5GHz 3V to 3.6V 38-Pin SMD |


## KiCad Programs
KiCad is a multiplatform and open source software to design PCBs.


- eeSchema – a schematic capture program
- Library Editor – a program to create schematic symbols
- PCBnew – a PCB layout tool
- Footprint Editor – a program to create PCB footprints
- CvPcb is a tool that allows you to associate components in your schematic to component footprints used when laying out the printed circuit board.
- Gerbview – a program to inspect Gerber files


## Process
1. Design circuit
2. Create schematic Symbol (Symbol Library Editor)
3. Schematic capture (eeSchema)
4. Create footprints (Footprint Editor)
5. Generate netlist (CvPcb)
6. Board layout (PCBnew)
7. Production (Gerbview)


## KiCad design rules

- [oshpark](https://docs.oshpark.com/design-tools/kicad/kicad-design-rules/)


### Rules
* Pads Mask Clearance (How much space there should be betwen the path and the start of the solder mask)
  - File > Board setup > Design Rules > Solder Mask / Paste
  - Oshpark -> 0.002 inches

## Trace width calculator

- [4pcb trace width calculator](https://www.4pcb.com/trace-width-calculator.html)

For power -> 0.762 mm (30 mils)


