#!/bin/bash

echo ShuffleVector && perf stat -r 1000 ./sfl_vec > /dev/null && echo ByteSwap && perf stat -r 1000 ./byte_swap > /dev/null
