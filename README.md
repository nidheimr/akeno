# Akeno

## Overview

Akeno is a very simple operating system with no real functionality with its own bootloader. It was written for educational purposes and is likely not very efficient.

## Usage

It can be run in most emulators, but if using QEMU you can run the following command after building:
1. `make test`

## Building

This project requires a linux environment with the following tools:
- `nasm`
- `make`

Assuming you have these tools installed, you can run the following command inside the project directory:
1. `make`

The binary will be placed inside `./bin/`.