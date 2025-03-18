#!/bin/sh

sudo dnf install python3-pip -y
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
RUSTC_WRAPPER= cargo install sccache --features="dist-client dist-server"
cargo install zoxide starship bat
