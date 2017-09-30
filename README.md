# CPUDesignProject

Implementation of a simple RISC style processor for on an Altera DE0 Cyclone III board. 
Created using VHDL and Altera Quartus II.
Project created for course project in ELEC 374 Computer Architecture course at Queen's University.

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes. See deployment for notes on how to deploy the project on a live system.

### Prerequisites

What things you need to install the software and how to install them

```
Altera Quartus II
Model Sim Altera Quartus Addon
Altera DE0 board (not required for only simulation activities)
```

## How to open project

1. Start Altera Quartus II
2. Open SRC_CPU.qpf project file
3. Investigate VHDL contents for each component of the CPU.
	1. Example, workingBooth.vhd implements the Booth's multiplication algorithm.
	2. Another example, datapath.vhd combines all components required for the CPU's datapath.
4. Use ModelSim to simulate various CPU functions. Image below shows a shift right register simulation (Other screenshots can be found in Simulation_Pictures directory).

![alt text](https://github.com/johan1252/CPUDesignProject/blob/master/Simulation_Pictures/shr_simulation_small_image.png?raw=true)
## Authors

Madeline Van Der Paelt
Maytha Nassor
Johan Cornelissen

## Acknowledgments

* Prof. Ahmad Afsahi, Instructor of ELEC 374 Computer Architecture during Winter 2016.
