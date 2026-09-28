#!/bin/bash
# Copyright 2020 Nokia
# Licensed under the BSD 3-Clause License.
# SPDX-License-Identifier: BSD-3-Clause

echo "Starting traffic client2"
docker exec client2 iperf3 -c 192.168.10.4 -u -b 1M -t 10000 > /dev/null 2>&1 &

echo "Starting traffic client3"
docker exec client3 iperf3 -c 192.168.10.1 -u -b 3M -t 10000 > /dev/null 2>&1 &

echo "Starting traffic clientpeer2"
docker exec clientpeer2 iperf3 -c 101.11.11.2 -u -b 6M -t 10000 > /dev/null 2>&1 &
