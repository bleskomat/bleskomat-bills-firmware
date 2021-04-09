# Bleskomat PCB

In order to make Bleskomat easy to reproduce in a consisten way and compress most of the cable complexity we are building this PCB. This PCB aims to connects all the component that are required for Bleskomat between them and with the microcontroler ESP32.


## Requirements
- [kiCad](https://kicad-pcb.org/)


## Resources to learn
### PCB building
- [An Intro to KiCad](https://www.youtube.com/watch?v=vaCVh2SAZY4&list=PL3bNyZYHcRSUhUXUt51W6nKvxx2ORvUQB)
  - It uses an older version of KiCad but still good
- [Tutorials](https://kicad-pcb.org/help/tutorials/)
- [Similar project](https://github.com/RuiSantosdotme/ESP32-Weather-Shield-PCB)


### Power connectors
- [What to do with third contact in DC barrel plug with only two input contacts](https://electronics.stackexchange.com/questions/90529/what-to-do-with-third-contact-in-dc-barrel-plug-with-only-two-input-contacts)
- [How to Select a Dc Power Connector](https://www.cuidevices.com/blog/how-to-select-a-dc-power-connector)


## Resources footprints

- [Kicad footprints](https://kicad.github.io/footprints/)
- [ultralibrarian -Kicad footprints and symbols](https://www.ultralibrarian.com/)


## PCB CAD Program

For designing the Bleskomat PCB we are using KiCad, it is a multiplatform and open source software to design PCBs.
Kicad is a set of multiple programs that work together in order to design a PCB. The process to follow when creating PCB is described in [Process](#process)

- eeSchema – a schematic capture program
- Library Editor – a program to create schematic symbols
- PCBnew – a PCB layout tool
- Footprint Editor – a program to create PCB footprints
- CvPcb is a tool that allows you to associate components in your schematic to component footprints used when laying out the printed circuit board.
- Gerbview – a program to inspect Gerber files


### Process of working in KiCad

1. Design circuit
This process is when you design you circuit in paper and maybe also build it using breadboard and jupmer cables. In this process you should find your components from a compnent's provider and if they have, collect also symbols and footprints from them.
2. Create schematic Symbol (Symbol Library Editor)
If you did not find symbol for some of the selected components you can create it with this editor in KiCad.
3. Schematic capture (eeSchema)
Once you have defined your circuit (and test it), you use this program to tell KiCad how all the componets are connected to each other. This is just logic, it is not the phisical representation.
4. Create footprints (Footprint Editor)
If you did not find footprints for some of the selected components you can create it with this editor in KiCad.
5. Generate netlist (CvPcb)
You generate netlist when you connect the symbols that you used in `eeSchema` with the footprints that each component is going to have.
6. Board layout (PCBnew)
Once you have fininished the previous steps you can click on update PCB in the program `PCBnew` and you will see all the components with wire lines of how they need to be connected.
7. Production (Gerbview)
This will produce the one file per each of the layers that the PCB is going to have.
8. BOM (Bill of Material)
Once you have finshed everything you can generate you BOM file. This file can be in different formats, we are using `csv`. You can generate this file if you click on `Generate Bill of Material` in the program `eeSchema` and use the script `bom2csv` like:
`xsltproc -o "%bleskomat-bom-v2.1.csv" "/usr/share/kicad/plugins/bom2csv.xsl" "%I"`.
9. Centroid/ Pick & Place file is a file with extension `.pos` that is required sometimes by the manufacturer to assembly automatically.
  - https://www.pcbway.com/helpcenter/technical_support/Generate_Position_File_in_Kicad.html
  - https://electronics.stackexchange.com/questions/456671/kicad-no-footprint-for-automated-placement
  A.Set the origin point
    Select the menu bar Place-> Drilling and Position Offset, place the origin at the bottom left corner of the PCB board frame, and then place [Layer Alignment Mark] to the position of the origin just placed.
  B.Generate Footprint Position File
    Click the menu [File] >> [Fabrication Output] >> [Footprint Position (.pos) File], select the output directory, other default, click [Generate Position File]. Open the package location file with Notepad or text editor. You can see the contents have reference number, value, package, X Y coordinate, orientation, board surface, etc.

    The checkbox 'Include footprints with SMD pads even if not marked Surface Mount' should be selected.


### KiCad design rules

- [oshpark](https://docs.oshpark.com/design-tools/kicad/kicad-design-rules/)


## Trace width calculator

- [4pcb trace width calculator](https://www.4pcb.com/trace-width-calculator.html)

For power -> 0.762 mm (30 mils)


## List of Components

Detailed list of components to be mounted on the PCB:

* epaper
  * 8 pins
  * https://www.digikey.com/en/products/detail/jst-sales-america-inc/B8B-XH-A-LF-SN/1651049
  * Symbol and footprint -> https://app.ultralibrarian.com/details/FA962F68-295C-11EA-A124-0AD2C9526B44/JST/B8B-XH-A--LF--SN-?ref=digikey

* Button connector
  * 2 pins
  * https://www.digikey.com/en/products/detail/jst-sales-america-inc/B2B-XH-A-LF-SN/1651045
  * Symbol and footprint -> https://app.ultralibrarian.com/details/7D7B9D86-5525-11E9-AB3A-0A3560A4CCCC/JST/B2B-XH-A-LF--SN-?ref=digikey

* Coin acceptor connector
  * 5 pins
  * https://www.digikey.com/en/products/detail/jst-sales-america-inc/B5B-XH-A-LF-SN/1530483
  * Symbol and footprint -> https://app.ultralibrarian.com/details/CFF72197-B726-11E9-AB3A-0A3560A4CCCC/JST/B5B-XH-A--LF--SN-

* NV9/10 bill acceptor connector
  * Socket to be soldered on the PCB:
    * https://www.digikey.com/en/products/detail/3m/30316-6002HB/1237397
    * Symbol and footprints -> https://app.ultralibrarian.com/details/B982199F-7F64-11EA-8C00-0AD2C9526B44/3M/30316-6002HB?ref=digikey

* Button resistor
  * 10K ohm
  * https://www.digikey.com/en/products/detail/yageo/CFR-25JB-52-10K/338
  * Symbol and footprint -> https://app.ultralibrarian.com/details/C2AE6AA6-1080-11E9-AB3A-0A3560A4CCCC/Yageo/CFR-25JB-52-10K

* Step down converter
  * 4 pins
  * Instead of using the step-down converter board/module, we can mount a single step-down converter component which outputs the exact voltage we know we want (3.3V at max. 500mA):

    * https://www.digikey.com/en/products/detail/recom-power/R-78E3-3-1-0/5327711
    * Symbol and footprint -> https://www.snapeda.com/parts/R-78E3.3-1.0/RECOM%20POWER%20GMBH/view-part/?ref=digikey

* 12V socket
  * 3 pins
  * https://www.digikey.com/en/products/detail/cui-devices/PJ-202A/252007
    * Footprint -> https://github.com/Digi-Key/digikey-kicad-library/blob/master/digikey-footprints.pretty/Barrel_Jack_5.5mmODx2.1mmID_PJ-202A.kicad_mod
* SDcard connector
  * https://www.digikey.com/en/products/detail/hirose-electric-co-ltd/DM3D-SF/1786510
  * Symbol and footprint -> https://app.ultralibrarian.com/details/2CC8D729-C606-11E9-AB3A-0A3560A4CCCC/Hirose/DM3D-SF?ref=digikey&open=exports&exports=KiCAD

* LED
  * https://www.digikey.com/en/products/detail/lite-on-inc/LTST-C194TBKT/2356225
  * Symbols and footprint -> https://www.snapeda.com/parts/LTST-C194TBKT/Lite-On%20Inc./view-part/?ref=digikey

* ESP32-WROOM-32SE
  * https://www.digikey.com/en/products/detail/espressif-systems/esp32-wroom-32-8mb/9381712
    * Symbol and footprint -> https://app.ultralibrarian.com/details/D182CFF0-E9AE-11E9-B85E-0AD2C9526B44/Espressif-Systems/ESP32-WROOM-32--8MB-?ref=digikey

* Firmware connector
  * 6 pins - to connect to this -> https://www.olimex.com/Products/IoT/Programmer/ESP-PROG/open-source-hardware
  * https://www.digikey.com/en/products/detail/jst-sales-america-inc/B6B-XH-A-LF-SN/1000381
  * Symbols and footprint -> https://app.ultralibrarian.com/details/7681E56E-AA22-11E9-AB3A-0A3560A4CCCC/JST/B6B-XH-A-LF--SN-?ref=digikey

* Switch to select source of power:
  * https://www.digikey.com/en/products/detail/c-k/JS202011CQN/1640097 - middle pins will connect to the ESP32's 3V3 pin
  * Symbol and footprint -> https://app.ultralibrarian.com/details/57BD9AFF-2115-11E9-AB3A-0A3560A4CCCC/C-K/JS202011CQN?ref=digikey

