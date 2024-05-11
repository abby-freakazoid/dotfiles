#!/bin/python3
# shuffle a list of files (eg from `find`), but keep them grouped by directory
# made to be used with `sxiv`

from sys import stdin
from os import path
import random

lines = {}

for file_path in stdin:
    file_path = file_path.rstrip()
    directory = path.dirname(file_path)

    if lines.get(directory) is None:
        lines[directory] = []
    lines[directory].append(file_path)

# random.seed(1)  # NOTE: fixed-seed
lines_dirs_shuffed = list(lines.keys())
random.shuffle(lines_dirs_shuffed)  # ! in-place operation

for directory in lines_dirs_shuffed:
    for line in lines[directory]:
        # print(line.encode('unicode_escape')) # works
        print(line)  # works just fine tbh
        # print(repr(line))  # doesn't work
