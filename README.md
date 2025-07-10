# Voting-Machine
# 🗳️ FSM-Based Digital Voting Machine using Verilog HDL

This repository contains the Verilog HDL implementation of a **Finite State Machine (FSM)-based Digital Voting Machine**. Designed for reliability and accuracy, this system enables users to cast votes using dedicated buttons and displays real-time vote counts, all controlled through FSM logic.

---

## 📄 Abstract

This project presents the design and implementation of a simple digital voting machine based on **Finite State Machines (FSM)** using **Verilog Hardware Description Language (HDL)**. The proposed system allows users to cast their votes for one of **four candidates** using dedicated input buttons.

To ensure **valid voting** and eliminate accidental presses, the system incorporates a **hold-time validation mechanism**, registering a vote only when the corresponding button is continuously pressed for a specified duration. Additionally, the design includes a **display mode** that enables real-time visualization of individual vote counts.

The FSM architecture efficiently manages:
- Voting control logic
- Debouncing and validation
- Display switching and count visualization

This project demonstrates the effectiveness of FSMs in **control-oriented digital systems** and highlights the practical application of HDL design methodologies in **embedded electronic voting systems**.

---

## ⚙️ Features

- ✅ Voting support for 4 candidates using button inputs
- ✅ Hold-time based vote validation (to avoid false triggers)
- ✅ Debouncing mechanism using FSM states
- ✅ Real-time vote display mode
- ✅ Modular Verilog design with clean state transitions
- ✅ FSM architecture ensures predictable behavior

---

## 💻 Technologies Used

- **Verilog HDL**
- **Finite State Machine Design**
- **Xilinx Vivado** (for simulation and synthesis)
- **Testbench-based validation**

---

