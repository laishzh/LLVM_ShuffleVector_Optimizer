#!/bin/bash

echo "SFL64" && perf stat -r 1000 ./sfl_vec_64 > /dev/null
echo "ByteSwap64" && perf stat -r 1000 ./byte_swap_64 > /dev/null
