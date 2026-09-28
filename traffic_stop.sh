#!/bin/bash
# Copyright 2020 Nokia
# Licensed under the BSD 3-Clause License.
# SPDX-License-Identifier: BSD-3-Clause

echo "Stopping traffic client2"
docker exec client2 killall iperf3 > /dev/null 2>&1 &

echo "Stopping traffic client3"
docker exec client3 killall iperf3 > /dev/null 2>&1 &

echo "Stopping traffic clientpeer2"
docker exec clientpeer2 killall iperf3 > /dev/null 2>&1 &
